/*
Author: Ryan Hurd
Class: Operating System Design - CS 47200
Professor: Dr. Chen
Date: 09/24/2020
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

// Struct Creation
struct function_args {
    char *arguments;
};

// Function Prototypes
void scrub(void);
void print_err();
char* chop(char* w);
void* analyze(void* arg);
void exec_com(char* args[], int args_num, FILE* out);
int forage(char path[], char* firstArg);
void digress(FILE* out);

// Main Function
int main(int argc, char** argv) {
	int interactive_mode = 1;
	in = stdin;
	size_t linemax = 0;
	ssize_t arg_line;

	if(argc > 1) {
		interactive_mode = 2;
		if(argc > 2 || (in = fopen(argv[1], "r")) == NULL) {
			print_err();
			exit(EXIT_FAILURE);
		}
	}

	while(1) {
		if(interactive_mode == 1) {
			printf("wish> ");
		}
		if ((arg_line = getline(&line, &linemax, in)) > 0) {
			char *arguments;
            int argument_num = 0;

            struct function_args args[SIZE];

            if(line[arg_line-1] == '\n') {
            	line[arg_line-1] = '\0';
            }

            char* line_temp = line;

            while((arguments = strsep(&line_temp, "&")) != NULL) {
			if (arguments[0] != '\0'){
                    args[argument_num++].arguments = strdup(arguments);
                    if (argument_num >= SIZE){
                        break;
                    }
                }
            }
            for(int i = 0; i < argument_num - 1; i++) {
            	int child;
            	child = fork();
            	if(child == 0) {
            		analyze(&args[i]);
            		atexit(scrub);
            		exit(EXIT_SUCCESS);
            	} else if(child < 0) {
            		print_err();
            	}
            }
            if(argument_num != 0) {
            	analyze(&args[argument_num - 1]);
            }
            for(int i = 0; i < argument_num - 1; i++) {
                wait(NULL);
            }
            for(int i = 0; i < argument_num; i++) {
            	if(args[i].arguments != NULL) {
            		free(args[i].arguments);
            	}
            }
        } else if(feof(in) != 0) {
			atexit(scrub);
			exit(EXIT_SUCCESS);
		}
	}
	free(line);
	return 0;
}


// Function Definitions
void scrub(void) {
	free(line);
	fclose(in);
}

void print_err() {
	char error_message[30] = "An error has occurred\n";
	write(STDERR_FILENO, error_message, strlen(error_message));
}

char* chop(char* w) {
	while(isspace(*w)) {
		w++;
	}
	if(*w == '\0') {
		return w;
	}
	char* end = w + strlen(w) - 1;
	while(end > w && isspace(*end)) {
		end--;
	}
	end[1] = '\0';
	return w;
}

void* analyze(void* arg) {
	char* args[SIZE];
	int args_num = 0;
	FILE* output = stdout;
	struct function_args *fun_args = (struct function_args *) arg;
	char *commandLine = fun_args->arguments;

	char* arguments = strsep(&commandLine, ">");

	if(arguments == NULL || *arguments == '\0') {
		print_err();
		return NULL;
	}

	arguments = chop(arguments);
	
	if(strncmp(arguments, "&", strlen(arguments)) == 0) {
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

		if((output = fopen(chop(commandLine), "w")) == NULL) {
			print_err();
			return NULL;
		}
	}

	char** x = args;
	while((*x = strsep(&arguments, " \t")) != NULL) {
		
		if(**x != '\0') {
			*x = chop(*x);
			x++;
			if(++args_num >= SIZE) {
				break;
			}
		}
	}

	if(args_num > 0) {	// && flag == 0
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
			atexit(scrub);
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
		if(forage(path, args[0]) == 0) {
			pid_t pid = fork();
			if(pid == -1) {
				print_err();
			}
			else if(pid == 0) {
				digress(out);
				char* line_temp = args[0];
				if(execv(path, args) == -1) {
					print_err();
				}
				free(args[0]);
				args[0] = line_temp;
			} else {
				waitpid(pid, NULL, 0);
			}
		} else {
			print_err();
		}
	}
}
   
int forage(char path[], char* firstArg) {
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

void digress(FILE* out) {
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