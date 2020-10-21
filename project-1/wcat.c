/* 
Author: Ryan Hurd
Class: CS 472
Project 1 - wcat.c
Date: September 4, 2020
*/

// Include statements
#include <stdio.h>
#include <stdlib.h>

// Function Headers
int error(int flag);								// Error function to print certain cases

// Main function
int main (int argc, char* argv[]) {
	// Variable creation and declaration
	FILE* fp;										// Create a file variable
	char ch;										// Create a char variable to store file output
	int i;											// Create a counter variable for our for loop
	int flag = -1;									// Create our flag variable to handle within our error() function
	
	if (argc < 2) {									// If our argument is less than two, return 0
		flag = 0;									// Set our flag to zero
		return error(flag);							// Return the value of error(0), which will also print the usage statement
	}	// End if loop
	
	for(i = 1; i < argc; i++) {						// While our coutner is between one and our passed in value, loop
		fp = fopen(argv[i], "r");					// Open our file for reading
		
		if(fp == NULL) {							// If our filename is null, state that we cannot open the file and return one
			flag = 1;								// Set our flag to one
			return error(flag);						// Return the value of error(1), which will also print the usage statement
		}	// End if section of loop

		while((ch = fgetc(fp)) != EOF) {			// While there is text to get, grab it from our file
			printf("%c", ch);						// Print the text
		}	// End while loop
		fclose(fp);									// Close our file
	}	// End for loop
	return 0;										// Return zero to show our program ended safely
}	// End main function

// Function Definition(s)
// Error function to print our usage based on flag's value
int error(int flag) {
	int temp = 0;									// Temp will be our returned value
	switch(flag) {									// Switch statement based on our flag
		case 0:										// If our case is zero, we simply need to return zero
			temp = 0;								// Set our temp equal to zero
			break;									// Break so that we don't continue down our cases
		case 1:										// If our case is one, the file could not be opened
			printf("wcat: cannot open file\n");		// Prompt user that file didn't open
			temp = 1;								// Set our temp equal to one
			break;									// Break so that we don't continue down our cases
		default:									// Default is a failsafe for if anything goes awry in our program
			temp = 0;								// Set our temp to zero
			break;									// Break so that we don't continue down our cases
	}	// End switch statement
	return temp;									// Return our temp value
}	// End error() function definition