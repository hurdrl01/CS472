/*
Authors: Ryan Hurd & Vinamra Munot
Professor: Dr. Chen
Course: CS 472 - Operating System Design
Project 6: Parallel Zip - Part 2
Date: December 1, 2020
Due Date: December 2, 2020 11:59 PM
*/


// Include Statements
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <string.h>
#include <sys/sysinfo.h>


// Error Message
#define error(msg) \
           do { perror(msg); exit(EXIT_FAILURE); } while (0)


// Pragma pack, helps with output
#pragma pack(1)


// Struct Creations
typedef struct res {
    int count;
    char character;
} Res;

typedef struct job {
	char *readBuff;
	int readSize;
	Res *resBuff;
	int resIndex;
} Job;

typedef struct queue {
	Job *head;
	Job *tail;
	pthread_mutex_t headLock, tailLock;
} Queue;


// Function Headers
void makeResult(int count, char character, Res *buff, int index);
void *process(void *arg);


// Main Function
int main(int argc, char** argv) {
	int numProcs = get_nprocs();

	if(argc < 2) {
		printf("pzip: file1 [file2 ...]\n");
		exit(1);
	}

	Res *buff = NULL;
	int index = 0;

	int max = argc - 1;
	for(int sentinel = 1; sentinel <= max; sentinel++) {
		int fd;
		struct stat sb;
		fd = open(argv[sentinel], O_RDONLY);
		if(fd == -1) {
			close(fd);
			error("open");
		}
		if(fstat(fd, &sb) == -1) {
			close(fd);
			error("fstat");
		}
		int len = sb.st_size;
		if(len == 0) {
			close(fd);
			continue;
		}
		char *address = mmap(NULL, len, PROT_READ, MAP_PRIVATE, fd, 0);
		close(fd);
		if(address == MAP_FAILED) {
			close(fd);
			error("mmap");
		}
		
		Job* tempJob;
		tempJob = malloc(sizeof(Job) * numProcs);
		
		
		pthread_t *pthr;
		pthr = malloc(sizeof(pthread_t) * numProcs);
		int prevLen = 0;

		for(int i = 0; i < numProcs; i++) {
			int block = len / numProcs;
			if(i == 0) {
				block += len % numProcs;
			}
			tempJob[i].readBuff = address + prevLen;
			tempJob[i].readSize = block;
			prevLen += block;
			pthread_create(pthr + i, NULL, process, tempJob + i);
		}
		for (int i = 0; i < numProcs; i++) {
			pthread_join(pthr[i], NULL);
			if(buff != NULL) {
				if(buff[index - 1].character == tempJob[i].resBuff[0].character) {
					tempJob[i].resBuff[0].count += buff[index - 1].count;
					index--;
				}
			}
			int freshIndex = tempJob[i].resIndex + index;
			buff = realloc(buff, (freshIndex * sizeof(Res)));
			memcpy(buff + index, tempJob[i].resBuff, tempJob[i].resIndex * sizeof(Res));
			index = freshIndex;
			free(tempJob[i].resBuff);
		}
		
		free(pthr);
		free(tempJob);
		
		munmap(address, len);
	}
	
	if(write(STDOUT_FILENO, buff, index * sizeof(Res)) !=-1);
	free(buff);
	return 0;
}


// Function Definitions
void makeResult(int count, char character, Res *buff, int index) {
	Res result;	
	result.count = count;
	result.character = character;
	buff[index] = result;
}

void *process(void *arg) {
	Job *zip = (Job*)arg;
	char *address = zip->readBuff;
	int len = zip->readSize;

	char character = address[0];
	int count = 0;
	int size = 10;
	int index = 0;

	Res *buff = malloc(size * sizeof(Res));

	for(int i = 0; i < len; i++) {
		char temp = address[i];

		if(temp == character) {
			count++;
		} else {
			if(i > size) {
				size *= 2;
				buff = realloc(buff, (size * sizeof(Res)));
			}
			makeResult(count, character, buff, index);
			
			character = temp;
			count = 1;
			index++;
		}
	}
	makeResult(count, character, buff, index);
	index++;

	zip->resBuff = buff;
	zip->resIndex = index;
	return NULL;
}