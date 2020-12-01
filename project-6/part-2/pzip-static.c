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


#define error(msg) \
           do { perror(msg); exit(EXIT_FAILURE); } while (0)

//made a function for checking if there is a file to open
/*FILE* open_file(char *filename) {
	FILE *fp = fopen(filename, "r");
	//if null, print out the required line
	if (fp == NULL) {
		printf("wzip: cannot open file\n");
		exit(1);
	}
	return fp;
}*/
#pragma pack(1)
typedef struct results {
    int count;
    char character;
} Result;

typedef struct job {
	char *readBuffer;
	int readSize;
	Result *resultBuffer;
	int resultIndex;
} zipJob;

typedef struct queue {
	zipJob *head;
	zipJob *tail;
	pthread_mutex_t headLock, tailLock;
} zipQueue;

void createResult(int count, char character, Result *buffer, int index) {
	Result result;	
	result.count = count;
	result.character = character;
	buffer[index] = result;
}

void *process(void *arg) {
	zipJob *zip = (zipJob*)arg;
	char *addr = zip->readBuffer;
	int length = zip->readSize;

	char character = addr[0];
	int count = 0;
	int size = 10;
	int index = 0;

	Result *buffer = malloc(size * sizeof(Result));

	for(int i = 0; i < length; i++) {
		char temp = addr[i];

		if(temp == character) {
			count++;
		} else {
			//checks to see if needs to realloc
			if(i > size) {
				size *= 2;
				buffer = realloc(buffer, (size * sizeof(Result)));
			}

			createResult(count, character, buffer, index);
			
			character = temp;
			count = 1;
			index++;
		}
	}
	createResult(count, character, buffer, index);
	index++;

	zip->resultBuffer = buffer;
	zip->resultIndex = index;
	return NULL;
}

int main(int argc, char** argv) {
	int threads = get_nprocs();

	//no files
	if(argc < 2) {
		printf("pzip: file1 [file2 ...]\n");
		exit(1);
	}

	Result *buffer = NULL;
	int index = 0;

	int maxFile = argc - 1;
	for(int current = 1; current <= maxFile; current++) {
		int fd;
		struct stat sb;
		fd = open(argv[current], O_RDONLY);
		if(fd == -1) {
			close(fd);
			error("open");
		}
		if(fstat(fd, &sb) == -1) {
			close(fd);
			error("fstat");
		}
		int length = sb.st_size;
		if(length == 0) {
			close(fd);
			continue;
		}
		char *addr = mmap(NULL, length, PROT_READ, MAP_PRIVATE, fd, 0);
		close(fd);
		if(addr == MAP_FAILED) {
			close(fd);
			error("mmap");
		}
		
		zipJob* myJob;
		myJob = malloc(sizeof(zipJob) * threads);
		
		
		pthread_t *p;
		p = malloc(sizeof(pthread_t) * threads);
		int prevLength = 0;

		for(int i = 0; i < threads; i++) {
			int chunk = length / threads;
			if(i == 0) {
				chunk += length % threads;
			}
			myJob[i].readBuffer = addr + prevLength;
			myJob[i].readSize = chunk;
			prevLength += chunk;
			pthread_create(p + i, NULL, process, myJob + i);
		}
		for (int i = 0; i < threads; i++) {
			pthread_join(p[i], NULL);
			if(buffer != NULL) {
				if(buffer[index - 1].character == myJob[i].resultBuffer[0].character) {
					myJob[i].resultBuffer[0].count += buffer[index - 1].count;
					index--;
				}
			}
			int newIndex = myJob[i].resultIndex + index;
			buffer = realloc(buffer, (newIndex * sizeof(Result)));
			memcpy(buffer + index, myJob[i].resultBuffer, myJob[i].resultIndex * sizeof(Result));
			index = newIndex;
			free(myJob[i].resultBuffer);
		}
		
		free(p);
		free(myJob);
		
		munmap(addr, length);
	}
	//printf("Character: %c count: %d\n", character, count);
	
	if(write(STDOUT_FILENO, buffer, index * sizeof(Result)) !=-1);
	free(buffer);
	return 0;
}