/* 
Author: Ryan Hurd
Class: CS 472
Project 1 - wzip.c
Date: September 2, 2020
*/

// Include statements
#include <stdio.h>
#include <stdlib.h>

// Function Header(s)
void writeAndPrint(int count, char prev);						// Function to write and print our infomration to a file
void advan_count(int* count, char ch, char* prev);				// Function to advance count and set prev equal ch

// Main function
int main(int argc, char* argv[]) {
	// Variable creation and declaration
	FILE* fp = NULL;											// Create our file pointer to open our files
	char ch;													// Create ch to track our current character
	int count = 0;												// Create count to track the usage of our current ch character
	int i = 0;													// Create i as a counter variable for our for loop
	char prev;													// Create prev to show which character was our previous char
	int flag = -1;												// Create flag variable to handle errors
	
	if(argc < 2) {												// If there are too few arguments, tell the user usage of executable
		flag = 0;												// Set flag to zero to show proper error
		return error(flag);										// Our function will print the error(0), and prompt user on what's wrong
	}	// End if loop
		
	for(i = 1; i < argc; i++) {									// While there are arguments, keep iterating
		fp = fopen(argv[i], "r");								// Open our file for reading
		if(fp == NULL) {										// If our file can't be opened, show an error
			flag = 1;											// Set our flag to one
			return error(flag);									// Our function will print error(1), and show proper error message
		}	// End if loop
		
		ch = fgetc(fp);											// Set ch equal to our first character in our file
		advan_count(&count, ch, &prev);							// Increment count and set prev equal to ch
		
		while((ch = fgetc(fp)) != EOF) {
			if(ch != prev) {									// If our current char does not equal our previous char, write to our file
				writeAndPrint(count, prev);						// Write and print our values to the file
					count = 0;									// Reset count to start recording a new value
		    }	// End if loop
		    advan_count(&count, ch, &prev);						// Increment count and set prev equal to ch
		}	// End while loop
	
		// If we're at the end of the line, don't reset count, but record our values
		if(ch == EOF && (i == (argc - 1))) {					// If we're at the end of our file, and our counter (i) is at the last file, write to a text file our results
			writeAndPrint(count, prev);							// Write and print our values to the file
		}	// End if loop
		fclose(fp);												// Close our file
	}	// End for loop
	return 0;													// Return zero to show program ended safely
}	// End main function

// FUNCTION DEFINITIONS
// Error function to print out statements based on the value of flag passed into the function
int error(int flag) {
	int temp = -1;												// Temp will store the value to be returned
	switch(flag) {												// Switch statement to decide the case for our flags
		case 0:													// If our flag is zero, the arguments were incorrect
			printf("wzip: file1 [file2 ...]\n");				// Prompt user on arguement usage
			temp = 1;											// Set temp to one
			break;												// Break so we do not continue going through cases
		case 1:													// If our flag is one, the file was not able to be opened
			printf("wzip: cannot open file:\n");				// Prompt user that the file didn't open
			temp = 1;											// Set temp to one
			break;												// Break so we do not continue going through cases
		default:												// Our default case returns zero in case the error function is entered improperly
			temp = 0;											// Set temp to zero
			break;												// Break so we do not continue going through cases
	}	// End switch statement
	return temp;												// Return our temp value
}	// End error() function definition

// Write and Print to file
void writeAndPrint(int count, char prev) {
	fwrite(&count, sizeof(count), 1, stdout);					// Write our count to our stdout
	fprintf(stdout, "%c", prev);								// Print our stdout to our file
}	// End writeAndPrint() function definition

// Advance count and set prev equal to ch
void advan_count(int* count, char ch, char* prev) {
	*count += 1;												// Increment count by one
	*prev = ch;													// Set prev equal to ch
} // End advan_count() function definition


