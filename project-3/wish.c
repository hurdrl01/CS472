/*
Author: Ryan Hurd
Class: Operating System Design - CS 47200
Professor: Dr. Chen
Date: 09/23/2020
Purpose: project-3 - Process Shell
*/

// Include Statements
#include <ctype.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>
#include <unistd.h>

// Global Variable Declarations
#define SIZE 256

FILE* in = NULL;
char* paths[SIZE] = {"/bin", NULL};
char* line = NULL;

int arg_count = 0;

char *path_output = NULL;
char *path_error = NULL;

// Function Prototypes
void clean(void);
void print_err();
char* trim(char* s);
void* parse(void* arg);
void exec_com(char* args[], int args_num, FILE* out);
int search(char path[], char* firstArg);
void redirect(FILE* out);

// Main Function
int main(int argc, char** argv) {
	int mode = 1;
	in = stdin;
	size_t linecap = 0;
	ssize_t nread;

	if(argc > 1) {
		mode = 2;
		if(argc > 2 || (in = fopen(argv[1], "r")) == NULL) {
			print_err();
			exit(EXIT_FAILURE);
		}
	}

	while(1) {
		if(mode == 1) {
			printf("wish> ");
		}
		if ((nread = getline(&line, &linecap, in)) > 0) {
			parse(line);
		} else if(feof(in) != 0) {
			atexit(clean);
			exit(EXIT_SUCCESS);
		}
	}
	free(line);
	return 0;
}


// Function Definitions
void clean(void) {
	free(line);
	fclose(in);
}

void print_err() {
	char error_message[30] = "An error has occurred\n";
	write(STDERR_FILENO, error_message, strlen(error_message));
}

char* trim(char* s) {
	while(isspace(*s)) {
		s++;
	}
	if(*s == '\0') {
		return s;
	}
	char* end = s + strlen(s) - 1;
	while(end > s && isspace(*end)) {
		end--;
	}
	end[1] = '\0';
	return s;
}

void* parse(void* arg) {
	char* args[SIZE];
	int args_num = 0;
	FILE* output = stdout;
	char* commandLine = arg;

	char* command = strsep(&commandLine, ">");
	
	if(command == NULL || *command == '\0') {
		print_err();
		return NULL;
	}

	command = trim(command);
	
	if(strncmp(command, "&", strlen(command)) == 0) {
		return NULL;
	}

	if(commandLine != NULL) {
		regex_t reg;
		if(regcomp(&reg, "\\S\\s+\\S", REG_EXTENDED) != 0) {
			print_err();
			regfree(&reg);
			return NULL;
		}
		if(regexec(&reg, commandLine, 0, NULL, 0) == 0 || strstr(commandLine, ">") != NULL) {
			print_err();
			regfree(&reg);
			return NULL;
		}
		regfree(&reg);

		if((output = fopen(trim(commandLine), "w")) == NULL) {
			print_err();
			return NULL;
		}
	}

	char** ap = args;
	while((*ap = strsep(&command, " \t")) != NULL) {
        if(**ap != '\0') {
			*ap = trim(*ap);
			ap++;
			if(++args_num >= SIZE) {
				break;
			}
		}
	}

	if(args_num > 0) {
		exec_com(args, args_num, output);
	}

	return NULL;
}

void exec_com(char* args[], int args_num, FILE* out) {
	if(strcmp(args[0], "exit") == 0) {
		if(args_num > 1) {
			print_err();
		}
		else {
			atexit(clean);
			exit(EXIT_SUCCESS);
		}
	} else if(strcmp(args[0], "cd") == 0) {
		if(args_num == 1 || args_num > 2) {
			print_err();
		} else if(chdir(args[1]) == -1) {
			print_err();
		}
	} else if(strcmp(args[0], "path") == 0) {
		size_t i = 0;
		paths[0] = NULL;
		for( ; i < args_num - 1; i++) {
			paths[i] = strdup(args[i + 1]);
		}
		paths[i + 1]  = NULL;
	} else {
		char path[SIZE];
		if(search(path, args[0]) == 0) {
			pid_t pid = fork();
			if(pid == -1) {
				print_err();
			}
			else if(pid == 0) {
				redirect(out);
				if(execv(path, args) == -1) {
					print_err();
				}
			} else {
				waitpid(pid, NULL, 0);
			}
		} else {
			print_err();
		}
	}
}
   
int search(char path[], char* firstArg) {
	int i = 0;
	while(paths[i] != NULL) {
		snprintf(path, SIZE, "%s/%s", paths[i], firstArg);
		if(access(path, X_OK) == 0) {
			return 0;
		}
		i++;
	}
	return -1;
}

void redirect(FILE* out) {
	int outFileno;
	if((outFileno = fileno(out)) == -1) {
		print_err();
		return;
	}
	if(outFileno != STDOUT_FILENO) {
		if(dup2(outFileno, STDOUT_FILENO) == -1) {
			print_err();
			return;
		}
		if(dup2(outFileno, STDERR_FILENO) == -1) {
			print_err();
			return;
		}
		fclose(out);
	}
}