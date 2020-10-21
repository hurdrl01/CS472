/* 
Author: Ryan Hurd
Class: CS 472
Project 1 - wgrep.c
Date: September 4, 2020
*/

// Preprocessor Directives
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Function Header(s)
int error(int flag);														// Error function to print certain cases
void vali_strstr(char* out, char* argv[]);									// Pass values in to use our strstr function
int size_ch(ssize_t size, char* out, size_t len, char* argv[]);				// A function to determine size of getline() with ch
void size_fp(ssize_t size, char* out, size_t len, FILE* fp, char* argv[]);	// A function to determine size of getline() with fp

// Main Function
int main(int argc, char* argv[]) {
	// Variable creation and declaration
	FILE* fp;																// Create file pointer
	size_t len = 0;															// Create len for line length
	ssize_t size = 0;														// Create size for line size
	char* out = NULL;														// Create out to store our lines
	int flag = -1;															// Create a flag variable so our error function knows what to print
		
	if(argc < 2) {															// If there are too few arguments
		flag = 0;															// Set our flag to zero
		return error(flag);													// Return our function's value to show problem
	}	// End if section of loop
	
	else if(argc == 2) {													// If a filename is not given		
		while((size = getline(&out, &len, stdin)) != -1) {					// While our size isn't negative one, keep iterating
			vali_strstr(out, argv);											// Use our function to call strstr()
		}	// End while loop
		flag = 1;															// Set our flag to one
		return error(flag);													// Return the value of our function call, which will also print what went wrong
	}	// End of else...if section of loop
	
	else {																	// For if a filename is given
		for(int i = 2; i < argc; i++) {										// While our i variable is less than our argument, loop
			fp = fopen(argv[i], "r");										// Open our file for reading
				
			if(fp == NULL) {												// If our file is NULL, return error
				return error(flag = 2);										// Return our function's value to show error occured
			}	// End nested if loop
			
			while((size = getline(&out, &len, fp)) != -1) {				// While our size isn't negative one, keep iterating
				vali_strstr(out, argv);										// Use our function to call strstr()
			} // End while loop
			
			fclose(fp);														// Close our file so there are no errors
		}	// End for loop
	}	// End if...else if...else loop

	return 0;																// Return zero to show our program ended successfully
}	// End main function

// Function Definition(s)
// Error function to show our problems based on our flag's value
int error(int flag) {
	int temp;																// Our temp value will be our return value
	switch(flag) {															// Our switch statement based on our flag's value
		case 0:																// If our flag is zero, there was improper argument usage
			printf("wgrep: searchterm [file ...]\n");						// Prompt user on proper argument usage
			temp = 1;														// Set our temp to one
			break;															// Break our switch so we don't continue through our cases
		case 1:																// If our flag is zero
			temp = 0;														// Set our temp to zero
			break;															// Break our switch so we don't continue through our cases
		case 2:																// If our flag is zero
			printf("wgrep: cannot open file\n");
			temp = 1;														// Set our temp to one
			break;															// Break our switch so we don't continue through our cases
		default:															// Our default is a failsafe for if the program breaks
			temp = 0;														// Set our temp to zero
			break;															// Break our switch so we don't continue through our cases
	}	// End switch statement
	return temp;															// Return the value of our temp
}	// End error() function definition

// Use strstr to print our values
void vali_strstr(char* out, char* argv[]) {
	if(strstr(out, argv[1])) {												// If strstr is valid, print our values
		printf("%s", out);													// Print the value of out
	}	// End if statement
}	// End vali_strstr() function definition

/* Attempt to make functions out of size = getline calls, but it is an infinite loop at test 4
int size_ch(ssize_t size, char* out, size_t len, char* argv[]) {
	int flag = -1;
	while((size = getline(&out, &len, stdin)) != 1) {
		vali_strstr(out, argv);
	}
	flag = 1;
	return error(flag);
}
void size_fp(ssize_t size, char* out, size_t len, FILE* fp, char* argv[]) {
	while((size = getline(&out, &len, fp)) != -1) {
		vali_strstr(out, argv);
	}
}
*/
