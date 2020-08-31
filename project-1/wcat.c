/* 
Author: Ryan Hurd
Class: CS 472
Project 1 - wcat.c
Date: August 31, 2020
*/

// Include statements
#include <stdio.h>
#include <stdlib.h>


// Main function
int main (int argc, char* argv[]) {
	
	// Variable creation and declaration
	int i;		// Create a counter variable
	FILE* f;	// Create a file variable
	char ch;	// Create a char variable to store file output
	
	if (argc < 2) {							// If our argument is less than two, return 0
		return 0;
	}	// End if loop
	
	for(i = 1; i < argc; i++) {				// While our coutner is between one and our passed in value, loop
		f = fopen(argv[i], "r");			// Open our file for reading
		
		if(f == NULL) {						// If our filename is null, state that we cannot open the file and return one
			printf("wcat: cannot open file\n");	// Prompt user on what went wrong
			return 1;						// Return one to end program
		}	// End if section of loop

		while((ch = fgetc(f)) != EOF) {		// While there is text to get, grab it from our file
			printf("%c", ch);				// Print the text
		}	// End while loop
		
		
		fclose(f);							// Close our file
	}	// End for loop

	return 0;								// Return zero to show our program ended safely
}	// End main function