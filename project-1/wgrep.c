/* 
Author: Ryan Hurd
Class: CS 472
Project 1 - wgrep.c
Date: September 2, 2020
*/

// Preprocessor Directives
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Main Function
int main(int argc, char* argv[]) {
	// Variable creation and declaration
	FILE* fp;												// Create file pointer
	size_t len = 0;											// Create len for line length
	ssize_t size = 0;										// Create size for line size
	char* out = NULL;										// Create out to store our lines
		
	if(argc == 1) {											// If there are too few arguments
		printf("wgrep: searchterm [file ...]\n");			// Prompt user
		return 1;											// Return one to show problem
	}	// End if section of loop
	
	else if(argc == 2) {									// If a filename is not given		
		while((size = getline(&out, &len, stdin)) != -1) {	// While there are lines to be got, get them
			if(strstr(out, argv[1])) {						// Determines if the string we are searching for is within our larger string
				printf("%s", out);							// Prints the line our string is in
			}	// End nested if loop
		}	// End while loop
		return 0;											// Return zero to show our program ended successfully
	}	// End of else...if section of loop
	
	else {													// For if a filename is given
		for(int i = 2; i < argc; i++) {						// While our i variable is less than our argument, loop
			fp = fopen(argv[i], "r");						// Open our file for reading
			
			if(fp == NULL) {								// If our file is NULL, return error
				printf("wgrep: cannot open file\n");		// Prompt user
				return 1;									// Return one to show error occured
			}	// End nested if loop
			
			while((size = getline(&out, &len, fp)) != -1) {	// While there are lines to be got, get them
				if(strstr(out, argv[1])) {					// Compare our output line with our argv word and see if it's in out
					printf("%s", out);						// Print our line
				}	// End nested if loop
			}	// End while loop
			
			fclose(fp);										// Close our file so there are no errors
		}	// End for loop
	}	// End if...else if...else loop

	return 0;												// Return zero to show our program ended successfully
}	// End main function