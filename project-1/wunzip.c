/* 
Author: Ryan Hurd
Class: CS 472
Project 1 - wunzip.c
Date: September 4, 2020
*/

// Preprocessor Directives
#include <stdio.h>
#include <stdlib.h>

// Function Headers
int error(int flag);									// Error function to print certain cases

// Main Function
int main(int argc, char* argv[]) {
	// Variable creation and declaration
	FILE* fp;											// Create file pointer to open files
	int num = -1;										// Create variable to read our number to
	int numout = -1;									// Create variable for the number being read
	int a, b, c;										// Create variable to store our values read from our binary file
	int flag = -1;										// Create our flag variable to handle within our error() function
	
	if(argc < 2) {										// If there are too few arguments
		flag = 0;										// Set our flag to zero
		return error(flag);								// Return the value of error(0), which will print what is wrong
	}	// End if loop
	
	for(int i = 1; i < argc; i++) {						// While there are arguments, keep iterating
		// Locally scoped variable declarations
		num = -1;										// Reset our variables so there aren't issues in our loop
		numout = -1;									// Reset our variables so there aren't issues in our loop
	
		fp = fopen(argv[i], "rb");						// Open our file for reading
		
		if(fp == NULL) {								// If our file is NULL, return error
			flag = 0;									// Set our flag to one
			return error(flag);							// Return the value of error(1), which will print what is wrong
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

// Function definition(s)
// Error function to print our usage based on flag's value
int error(int flag) {
	int temp;											// Temp will be our return value after we handle each case
	switch(flag) {										// Switch based on our flags value
		case 0:											// If the arguments provided were not correct
			printf("wunzip: file1 [file2 ...]\n");		// Prompt user that arguments usage was incorrect
			temp = 1;									// Set temp to one
			break;										// Break so we don't continue through cases
		case 1:											// If our file doesn't open, show proper error message
			printf("Cannot open file\n");				// Prompt user that the file couldn't be opened
			temp = 1;									// Set temp to one
			break;										// Break so we don't continue through cases
		default:										// Failsafe in case program fails
			temp = 0;									// Set temp to zero
			break;										// Break so we don't continue through cases
	}	// End switch statement
	return temp;										// Return our temp value 
}	// End error() function definition