/*
Project 6 - Parallel Zip
Author(s): Ryan Hurd & Vinamra Munot
Professor: Dr. Chen
Course: CS 472 - Operating System Design
Due Date: December 2, 2020 11:59 PM
*/


////////////////////////////////////////////////////////////////////////
/*							LIBRARIES								  */
////////////////////////////////////////////////////////////////////////
#include <fcntl.h>							// Library for file control options
#include <stdio.h>							// Library for standard input/output
#include <stdlib.h>							// Library for general purpose functionality
#include<string.h>							// Library for strings
#include <sys/mman.h> 						// Library for mmap
#include <pthread.h>						// Library for pthread
#include <sys/stat.h> 						// Library for struct stat
#include <sys/sysinfo.h>					// Library for system info (nproc)
#include <unistd.h>							// Library for POSIX operating system API



////////////////////////////////////////////////////////////////////////
/*						GLOBAL VARIABLES							  */
////////////////////////////////////////////////////////////////////////
int num_thread; 							// Total number of threads that will be created for consumer.
int pg_sz; 									// Page size = 4096 Bytes
int num_files; 								// Total number of the files passed as the arguments.
int isComp=0; 								// Flag to wakeup 
//Flag needed to wakeup any sleeping threads at the end of program.

int total_pages; 							// To compress output
int q_head=0; 								// Queue head.
int q_tail=0; 								// Queue tail.
#define q_capacity 10 						// Queue current size
int q_size=0; 								// Queue capacity.
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER, filelock=PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t empty = PTHREAD_COND_INITIALIZER, fill = PTHREAD_COND_INITIALIZER;
int* pagePerFile;



////////////////////////////////////////////////////////////////////////
/*							STRUCTURES								  */
////////////////////////////////////////////////////////////////////////
struct output {								//Contains the compressed output
	char* data;
	int* count;
	int size;
} *out;

struct buffer {								// Contains page data specific to a file
    char* address; 							// Address to map, file_number file + page_number page
    int file_number; 						// File Number
    int page_number; 						// Page number
    int last_pg_sz; 						// Page sized 
} buf[q_capacity];

struct fd{									// Contains file specific data for munmap
	char* addr;
	int size;
} *files;



////////////////////////////////////////////////////////////////////////
/*						FUNCTION HEADERS							  */
////////////////////////////////////////////////////////////////////////
void put(struct buffer b);
struct buffer get() {						// Remove from q_tail index of the circular queue.
  	struct buffer b = buf[q_tail]; 			// Dequeue the buffer.
	q_tail = (q_tail + 1) % q_capacity;
  	q_size--;
  	return b;
}
void* producer(void *arg);
struct output RLECompress(struct buffer temp);
int calculateOutputPosition(struct buffer temp);
void *consumer();
void printOutput();
void freeMemory();



////////////////////////////////////////////////////////////////////////
/*						MAIN FUNCTION								  */
////////////////////////////////////////////////////////////////////////
int main(int argc, char* argv[]) {
	// Check if less than two arguments are given
	if(argc<2) {
		printf("pzip: file1 [file2 ...]\n");
		exit(1);
	}

	// Variable creation and declaration
	pg_sz = 4096;									// Size of a page
	num_files=argc-1; 								// Number of files, necessary for producer
	num_thread=get_nprocs(); 						// Number of processes consumer threads 
	pagePerFile=malloc(sizeof(int)*num_files); 		// Number of pages per file
    out=malloc(sizeof(struct output)* 512000*2); 	// Output variable
	
	// Create thread of producer to map files
	pthread_t pid,cid[num_thread];
	pthread_create(&pid, NULL, producer, argv+1); 	// argv[0] is not need, so we skip that by using argv + 1

	// Create thread of consumer to compress all pages in a file
	for (int i = 0; i < num_thread; i++) {
        pthread_create(&cid[i], NULL, consumer, NULL);
    }

	// Wait for producers and consumer to finish
    for (int i = 0; i < num_thread; i++) {
        pthread_join(cid[i], NULL);
    }

	// Join the threads
    pthread_join(pid,NULL);
	
	// Print the output
	printOutput();

	freeMemory();
	return 0;
}


////////////////////////////////////////////////////////////////////////
/*					FUNCTION DEFINITIONS							  */
////////////////////////////////////////////////////////////////////////
// buf is Buffer queue with capacity of 10
// Add a q_head index  
void put(struct buffer b) {
  	buf[q_head] = b; //Enqueue the buffer
  	q_head = (q_head + 1) % q_capacity;
  	q_size++;
}



/*					Producer Stuff									  */
// Producer function for memory mapping files that are passed as arguments
void* producer(void *arg) {
	char** filenames = (char **)arg;
	struct stat sb;
	char* map; 										// mmap address
	int file;
	
	for(int i=0;i<num_files;i++) {
		file = open(filenames[i], O_RDONLY);
		int pages_in_file=0; 						// Calculate the number of page in the file. Number of pages = Size of file / Page size.
		int last_pg_sz=0; 							// Variable required if the file is not page-alligned ie Size of File % Page size !=0
		
		if(file == -1) {
			printf("Error: File didn't open\n");
			exit(1);
		}

		if(fstat(file,&sb) == -1) { 
			close(file);
			printf("Error: Couldn't retrieve file stats");
			exit(1);
		}
		
        	if(sb.st_size==0) {
               		continue;
        	}

		pages_in_file=(sb.st_size/pg_sz);

		if(((double)sb.st_size/pg_sz)>pages_in_file) { 
			pages_in_file+=1;
			last_pg_sz=sb.st_size%pg_sz;
		}
		else { 
			last_pg_sz=pg_sz;
		}
		total_pages+=pages_in_file;
		pagePerFile[i]=pages_in_file;

		map = mmap(NULL, sb.st_size, PROT_READ, MAP_SHARED, file, 0);														  
		if (map == MAP_FAILED) { 
			close(file);
			printf("Error mmapping the file\n");
			exit(1);
    	}	
    	
		for(int j=0;j<pages_in_file;j++) {
			pthread_mutex_lock(&lock);
			while(q_size==q_capacity) {
			    pthread_cond_broadcast(&fill); 
				pthread_cond_wait(&empty,&lock);
			}
			pthread_mutex_unlock(&lock);
			struct buffer temp;
			if(j==pages_in_file-1) {
				temp.last_pg_sz=last_pg_sz;
			}
			else{
				temp.last_pg_sz=pg_sz;
			}
			temp.address=map;
			temp.page_number=j;
			temp.file_number=i;
			map+=pg_sz; 

			pthread_mutex_lock(&lock);
			put(temp);
			pthread_mutex_unlock(&lock);
			pthread_cond_signal(&fill);
		}
		close(file);
	}
	isComp=1;
	pthread_cond_broadcast(&fill);
	return 0;
}



/*					Consumer Stuff									  */
struct output RLECompress(struct buffer temp) {
	struct output compressed;
	compressed.count=malloc(temp.last_pg_sz*sizeof(int));
	char* tempString=malloc(temp.last_pg_sz);
	int countIndex=0;
	for(int i=0;i<temp.last_pg_sz;i++) {
		tempString[countIndex]=temp.address[i];
		compressed.count[countIndex]=1;
		while(i+1<temp.last_pg_sz && temp.address[i]==temp.address[i+1]) {
			compressed.count[countIndex]++;
			i++;
		}
		countIndex++;
	}
	compressed.size=countIndex;
	compressed.data=realloc(tempString,countIndex);

	return compressed;
}



int calculateOutputPosition(struct buffer temp) {
	int position=0;
	for(int i=0;i<temp.file_number;i++) {
		position+=pagePerFile[i];
	}
	position+=temp.page_number;
	return position;	
}


void *consumer() {
	do{
		pthread_mutex_lock(&lock);
		while(q_size==0 && isComp==0) {
		    pthread_cond_signal(&empty);
			pthread_cond_wait(&fill,&lock); 
		}
		if(isComp==1 && q_size==0) { 
			pthread_mutex_unlock(&lock);
			return NULL;
		}
		struct buffer temp=get();
		if(isComp==0) {
		    pthread_cond_signal(&empty);
		}	
		pthread_mutex_unlock(&lock);
		int position=calculateOutputPosition(temp);
		out[position]=RLECompress(temp);
	}while(!(isComp==1 && q_size==0));
	return NULL;
}

/*					Main Stuff									  */
void printOutput() {
	char* finalOutput=malloc(total_pages*pg_sz*(sizeof(int)+sizeof(char)));
    char* init=finalOutput; 
    for(int i=0;i<total_pages;i++) {
		if(i<total_pages-1) {
			if(out[i].data[out[i].size-1]==out[i+1].data[0]) {
				out[i+1].count[0]+=out[i].count[out[i].size-1];
				out[i].size--;
			}
		}
		
		for(int j=0;j<out[i].size;j++) {
			int num=out[i].count[j];
			char character=out[i].data[j];
			*((int*)finalOutput)=num;
			finalOutput+=sizeof(int);
			*((char*)finalOutput)=character;
            finalOutput+=sizeof(char);
		}
	}
	fwrite(init,finalOutput-init,1,stdout);
	free(init);
}


void freeMemory() {
	free(pagePerFile);
	for(int i=0;i<total_pages;i++) {
		free(out[i].data);
		free(out[i].count);
	}
	free(out);
}