/*
Authors: Ryan Hurd & Vinamra Munot
Professor: Dr. Chen
Course: CS 472 - Operating System Design
Project 6: Parallel Zip - Part 1
Date: November 18, 2020
Due Date: November 18, 2020 11:59 PM
*/

// Include Statements
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>

// Error Code Definition
#define ERROR_CODE 1

// Function Headers
int error(int flag);

// Error Message Definition
#define handle_err(msg)     \
	do                      \
	{                       \
		perror(msg);        \
		exit(EXIT_FAILURE); \
	} while (0)

// Main Function
int main(int argc, char **argv) {
	// Variable Creation and Declaration	
	int count = 0, hit = 0;
	int fd;
	char prev_char = 0, curr_char = 0;
	char *addr;	
	off_t offset, pa_offset;
	size_t length = 0;
	ssize_t s = 0;

	// If the arguments are less then one, a file wasn't provided
	if (argc <= 1) {
		printf("pzip: file1 [file2 ...]\n");
		exit(ERROR_CODE);
	} // End if statement

	// So long as there are arguments to be taken, iterate through
	for (int i = 1; i < argc; i++) {
		// Local Variable Creation and Declaration
		struct stat sb;
		offset = atoi(argv[i]);
		pa_offset = offset & ~(sysconf(_SC_PAGE_SIZE) - 1);
		int k = 0;

		// Open the file as readonly
		fd = open(argv[i], O_RDONLY);
		
		// If fstat fails, output an error
		if (fstat(fd, &sb) == -1) {
			handle_err("fstat");
		} // End if statement
		
		// So long
		if (offset >= sb.st_size)
		{
			fprintf(stderr, "offset is past end of file\n");
			exit(EXIT_FAILURE);
		} // End if statement
		
		// Set length equal to sb's size minus offset
		length = sb.st_size - offset;

		// Use mmap to fill our addr variable
		addr = mmap(NULL, length + offset - pa_offset, PROT_READ, MAP_PRIVATE, fd, pa_offset);
		
		// If this fails, output an error
		if (addr == MAP_FAILED) {
			printf("MMAP ERROR");
		} // End if statement
		
		// Compress the file's contents
		while(1) {
			// Set our curr_char to the value in addr at index k
			curr_char = addr[k];
			k++;

			// If curr_char is null, write it
			if (curr_char == '\0') {
				// Increment hit
				hit++;

				// Write to our file based on the count and hit values
				if (count > 0 && hit > 2) {
					s = write(1, &count, 4);
					s = write(1, &prev_char, 1);
				} // End if statement
				else if (argc == 2 && hit == 1 && count > 0) {
					s = write(1, &count, 4);
					s = write(1, &prev_char, 1);
				} // End if...else statement
				break;
			} // End if statement
			
			// If the curr_char isn't equal to prev_char, write the values
			if (curr_char != prev_char)	{
				if (count > 0) {
					s = write(1, &count, 4);
					s = write(1, &prev_char, 1);
				} // End if statement
				count = 0;
			} // End if statement
			
			// Increment count and our advance our prev char
			count++;
			prev_char = curr_char;
		} // End while statement

		// If the length of s isn't valid, output an error
		if (s != length) {
			if (s == -1) {
				handle_err("write");
			} // End if statement
		} // End if statement
		munmap(addr, length + offset - pa_offset);
		close(fd);
	} // End for loop
	return 0;
} // End Main function

// Function Definition
int error(int flag) {
	// Local Variable Creation
	int temp = -1;
	
	// Switch Statement
	switch (flag) {
		
		// If our flag is zero, prompt user on usage
		case 0:
			printf("pzip: file1 [file2 ...]\n");
			temp = 1;
			break;
		
		// If our flag is zero, prompt that the file is incorrect
		case 1:
			printf("pzip: cannot open file:\n");
			temp = 1;
			break;

		// Default statement
		default:								 
			temp = 0;							 
			break;								 
	} // End switch statement

	// Return our temp value										 
	return temp;							 
} // End error() function definition