/*
Authors: Ryan Hurd & Vinamra Munot
Professor: Dr. Chen
Course: CS 472 - Operating System Design
Project 6: Parallel Zip - Part 1
Date: November 17, 2020
Due Date: November 18, 2020 11:59 PM
*/

// Include statements
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
// Added Includes
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>


// Function Header(s)
int error(int flag);
void writeAndPrint(int count, char prev) 						// Write and Print to file

#define handle_err(msg) \
	do { perror(msg); exit(EXIT_FAILURE); } while(0)

// Main function
int main(int argc, char* argv[]) {
	// Variable creation and declaration
	char* addr;
	int fd = 0;
	struct stat sb;
	size_t length = 0;
	ssize_t s = 0;
	int flag = 0;
	off_t offset, pa_offset;
	
	
	if(argc < 2) {                                              // If there are too few arguments, tell the user usage of executable
		flag = 0;                                               // Set flag to zero to show proper error
		return error(flag);                                     // Our function will print the error(0), and prompt user on what's wrong
	}   // End if loop
	
	for(int i = 1; i < argc; i++) {                                 // While there are arguments, keep iterating
		fd = open(argv[i], O_RDONLY);
		if(fstat(fd, &sb) == -1) {
			handle_err("fstat");
		}

		offset = atoi(argv[i]);
		pa_offset = offset & ~(sysconf(_SC_PAGE_SIZE) - 1);

		if(offset >= sb.st_size) {
			fprintf(stderr, "offset is past end of file\n");
			exit(EXIT_FAILURE);
		}
		length = sb.st_size - offset;

		addr = mmap(NULL, length + offset - pa_offset, PROT_READ, MAP_PRIVATE, fd, pa_offset);
		if(addr == MAP_FAILED) 
			handle_err("mmap");

		int count = 0;
		int temp;
		for (int j = 0; j < strlen(addr)-1; j++){
  			if(addr[j] == addr[j+1]) {
    			count++;
  			}
		}

		s = write(STDOUT_FILENO, addr + offset - pa_offset, length);
		if(s != length) {
			if(s == -1) {
				handle_err("write");
			}
			fprintf(stderr, "partial write");
			exit(EXIT_FAILURE);
	}

		munmap(addr, length + offset - pa_offset);
		close(fd);
	}
	exit(EXIT_SUCCESS);

}   // End main function


// FUNCTION DEFINITIONS
// Error function to print out statements based on the value of flag passed into the function
int error(int flag) {
	int temp = -1;                                              // Temp will store the value to be returned
	switch(flag) {                                              // Switch statement to decide the case for our flags
		case 0:                                                 // If our flag is zero, the arguments were incorrect
			printf("pzip: file1 [file2 ...]\n");                // Prompt user on arguement usage
			temp = 1;                                           // Set temp to one
			break;                                              // Break so we do not continue going through cases
		case 1:                                                 // If our flag is one, the file was not able to be opened
			printf("pzip: cannot open file:\n");                // Prompt user that the file didn't open
			temp = 1;                                           // Set temp to one
			break;                                              // Break so we do not continue going through cases
		default:                                                // Our default case returns zero in case the error function is entered improperly
			temp = 0;                                           // Set temp to zero
			break;                                              // Break so we do not continue going through cases
	}   // End switch statement
	return temp;                                                // Return our temp value
}   // End error() function definition

// Write and Print to file
void writeAndPrint(int count, char prev) {
	fwrite(&count, sizeof(count), 1, stdout);					// Write our count to our stdout
	fprintf(stdout, "%c", prev);								// Print our stdout to our file
}	// End writeAndPrint() function definition