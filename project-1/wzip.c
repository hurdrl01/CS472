/* 
Author: Ryan Hurd
Class: CS 472
Project 1 - wzip.c
Date: September 2, 2020
*/

// Include statements
#include <stdio.h>
#include <stdlib.h>

// Main function
int main(int argc, char* argv[]) {
	// Variable creation and declaration
	FILE* fp = NULL;											// Create our file pointer to open our files
	char ch;													// Create ch to track our current character
	int count = 0;												// Create count to track the usage of our current ch character
	int i = 0;													// Create i as a counter variable for our for loop
	char prev;													// Create prev to show which character was our previous char
	
	if(argc < 2) {												// If there are too few arguments, tell the user usage of executable
		printf("wzip: file1 [file2 ...]\n");					// Prompt user on usage
		return 1;												// Return one to show an error
	}	// End if loop
	
	for(i = 1; i < argc; i++) {									// While there are arguments, keep iterating
		fp = fopen(argv[i], "r");								// Open our file for reading
		if(fp == NULL) {										// If our file can't be opened, show an error
			printf("wzip: cannot open file:\n");				// Prompt user
			return 1;											// Return one to show an error
		}	// End if loop
		
		ch = fgetc(fp);											// Set ch equal to our first character in our file
		count++;												// Increment count
		prev = ch;												// Set our previous char equal to our current char
		
		while((ch = fgetc(fp)) != EOF) {
			if(i != (argc - 1)) {								// If we're not at the last file in our arguments, don't write to file yet
				if(ch != prev) {								// If our current char does not equal our previous char, write to our file
		            fwrite(&count, sizeof(count), 1, stdout);	// Return bytes written
		            fprintf(stdout, "%c", prev);				// Write our bytes to text file
		            count = 0;									// Set our count to zero
		        }	// End if loop
		        count++;										// Increment count
		        prev = ch;										// Set our previous char equal to our current char
		    }	// End if section of loop
		    
		    else {												// If there is only one argument, write to file accordingly
		    	if(ch != prev) {								// If our current char does not equal our previous char, write to our file
		            fwrite(&count, sizeof(count), 1, stdout);	// Return bytes written
		            fprintf(stdout, "%c", prev);				// Write our bytes to text file
		            count = 0;									// Set our count to zero
		        }	// End if loop
		        count++;										// Increment count
		        prev = ch;										// Set our previous char equal to our current char
		    }	// End if...else loop
		}	// End while loop
		
		if(ch == EOF && (i == (argc - 1))) {					// If we're at the end of our file, and our counter (i) is at the last file, write to a text file our results
			fwrite(&count, sizeof(count), 1, stdout);			// Return bytes writen
			fprintf(stdout, "%c", prev);						// Write bytes to text file
		}	// End if loop
		fclose(fp);												// Close our file
	}	// End for loop
	return 0;													// Return zero to show program ended safely
}	// End main function
