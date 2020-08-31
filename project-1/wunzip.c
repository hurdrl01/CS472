/* 
Author: Ryan Hurd
Class: CS 472
Project 1 - wunzip.c
Date: August 31, 2020
*/

// Preprocessor Directives
#include <stdio.h>
#include <stdlib.h>

// Main Function
int main(int argc, char* argv[]) {
	// Variable creation and declaration
	FILE* fp;											// Create file pointer to open files
	int num = -1;										// Create variable to read our number to
	int numout = -1;									// Create variable for the number being read
	int a, b, c;										// Create variable to store our values read from our binary file
	
	

	if(argc < 2) {										// If there are too few arguments
		printf("wunzip: file1 [file2 ...]\n");			// Prompt user
		return 1;										// Return one to show problem
	}	// End if loop
	
	for(int i = 1; i < argc; i++) {						// While there are arguments, keep iterating
		// Locally scoped variable declarations
		num = -1;										// Reset our variables so there aren't issues in our loop
		numout = -1;									// Reset our variables so there aren't issues in our loop
	
		fp = fopen(argv[i], "rb");						// Open our file for reading
		
		if(fp == NULL) {								// If our file is NULL, return error
			printf("Cannot open file\n");				// Prompt user
			return 1;									// Return one to show error occured
		}	// End if loop
															
		while(numout != 0) {							// While there are numbers to be read, iteratre
			numout = fread(&num, sizeof(int), 1, fp);	// Read a value from our file and store it into numout
			a = fread(&b, sizeof(char), 1, fp);			// read values into our a value
			if(a != 0) {								// So long as our a isn't 0, print values
				for(c = 0; c < num; c++) {				// While our c is less than our num variable, iterate
					printf("%c", b);					// Print the value of b
				}	// End for loop
			}	// End if loop
		}	// End while loop
		
		fclose(fp);										// Close our file so there are no errors
		}	// End for loop

	return 0;											// Return zero to show our program ended successfully
}	// End main function