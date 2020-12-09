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
int total_threads; 							// Total number of threads that will be created for consumer.
int page_size; 								// Page size = 4096 Bytes
int num_files; 								// Total number of the files passed as the arguments.
int isComplete=0; 							// Flag to wakeup 
//Flag needed to wakeup any sleeping threads at the end of program.

int total_pages; 							// To compress output
int q_head=0; 								// Queue head.
int q_tail=0; 								// Queue tail.
#define q_capacity 10 						// Queue current size
int q_size=0; 								// Queue capacity.
pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER, filelock=PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t empty = PTHREAD_COND_INITIALIZER, fill = PTHREAD_COND_INITIALIZER;
int* pages_per_file;



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
    int last_page_size; 					// Page sized 
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
int main(int argc, char* argv[]){
	// Check if less than two arguments are given
	if(argc<2){
		printf("pzip: file1 [file2 ...]\n");
		exit(1);
	}

	// Variable creation and declaration
	page_size = 4096;								// Size of a page
	num_files=argc-1; 								// Number of files, necessary for producer
	total_threads=get_nprocs(); 					// Number of processes consumer threads 
	pages_per_file=malloc(sizeof(int)*num_files); 	// Number of pages per file
    out=malloc(sizeof(struct output)* 512000*2); 	// Output variable
	
	// Create thread of producer to map files
	pthread_t pid,cid[total_threads];
	pthread_create(&pid, NULL, producer, argv+1); 	// argv[0] is not need, so we skip that by using argv + 1

	// Create thread of consumer to compress all pages in a file
	for (int i = 0; i < total_threads; i++) {
        pthread_create(&cid[i], NULL, consumer, NULL);
    }

	// Wait for producers and consumer to finish
    for (int i = 0; i < total_threads; i++) {
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
//buf is the Buffer queue. Queue capacity by default = 10
//Add at q_head index of the circular queue. 
void put(struct buffer b){
  	buf[q_head] = b; //Enqueue the buffer
  	q_head = (q_head + 1) % q_capacity;
  	q_size++;
}



/*					Producer Stuff									  */
// Producer function for memory mapping files that are passed as arguments
void* producer(void *arg){
	//Step 1: Get the file.
	char** filenames = (char **)arg;
	struct stat sb;
	char* map; //mmap address
	int file;
	
	//Step 2: Open the file
	for(int i=0;i<num_files;i++){
		//printf("filename %s\n",filenames[i]);
		file = open(filenames[i], O_RDONLY);
		int pages_in_file=0; //Calculates the number of pages in the file. Number of pages = Size of file / Page size.
		int last_page_size=0; //Variable required if the file is not page-alligned ie Size of File % Page size !=0
		
		if(file == -1){ //yikes , possible due to file not found?
			printf("Error: File didn't open\n");
			exit(1);
		}

		//Step 3: Get the file info.
		if(fstat(file,&sb) == -1){ //yikes #2.
			close(file);
			printf("Error: Couldn't retrieve file stats");
			exit(1);
		}
		//Empty files - Test 5
        	if(sb.st_size==0){
               		continue;
        	}
		//Step 4: Calculate the number of pages and last page size.
		//st_size contains the size offset. 
		pages_in_file=(sb.st_size/page_size);
		//In case file is not page alligned, we'll need to assign an extra page.
		if(((double)sb.st_size/page_size)>pages_in_file){ 
			pages_in_file+=1;
			last_page_size=sb.st_size%page_size;
		}
		else{ //Page alligned
			last_page_size=page_size;
		}
		total_pages+=pages_in_file;
		pages_per_file[i]=pages_in_file;
		//Compressed output pointer. Re-allocates for every new page.
		/*if(out==NULL){
			out=malloc(total_pages*sizeof(struct output));
		}
		else{
			struct output* newOut=realloc(out,sizeof(struct output)*total_pages);
			if(newOut==NULL){
				printf("Error: Problem with re-allocating\n");
				exit(1);
			}
			else{
				out=newOut;
			}
		}*/
		//Step 5: Map the entire file.
		map = mmap(NULL, sb.st_size, PROT_READ, MAP_SHARED, file, 0); //If addr is NULL, then the kernel chooses the (page-aligned) address
		//at which to create the mapping. Source: man pages															  
		if (map == MAP_FAILED) { //yikes #3,possibly due to no memory? --unmap needed then?
			close(file);
			printf("Error mmapping the file\n");
			exit(1);
    	}	
    	
    	//Needed for munmap
    	// files[i].addr=map;
    	// files[i].size=sb.st_size;
    	//Step 6: For all the pages in file, create a Buffer type data with the relevant information for the consumer.
		for(int j=0;j<pages_in_file;j++){
			pthread_mutex_lock(&lock);
			while(q_size==q_capacity){
			    pthread_cond_broadcast(&fill); //Wake-up all the sleeping consumer threads.
				pthread_cond_wait(&empty,&lock); //Call the consumer to start working on the queue.
			}
			pthread_mutex_unlock(&lock);
			struct buffer temp;
			if(j==pages_in_file-1){ //Last page, might not be page-alligned
				temp.last_page_size=last_page_size;
			}
			else{
				temp.last_page_size=page_size;
			}
			temp.address=map;
			temp.page_number=j;
			temp.file_number=i;
			map+=page_size; //Go to next page in the memory.
			//possible race condition while changing size.
			pthread_mutex_lock(&lock);
			put(temp);
			pthread_mutex_unlock(&lock);
			pthread_cond_signal(&fill);
		}
		//Step 7: Close the file.
		close(file);
	}
	//Possible race condition at isComplete?
	isComplete=1; //When producer is done mapping.
	//Debugging step: Program wasn't ending during some runtimes as consumer threads were waiting for work.
	pthread_cond_broadcast(&fill); //Wake-up all the sleeping consumer threads.
	//printf("producer exiting with queue_size %d\n",q_size);
	return 0;
}



/*					Consumer Stuff									  */
//Compresses the buffer object.
struct output RLECompress(struct buffer temp){
	struct output compressed;
	compressed.count=malloc(temp.last_page_size*sizeof(int));
	char* tempString=malloc(temp.last_page_size);
	int countIndex=0;
	for(int i=0;i<temp.last_page_size;i++){
		tempString[countIndex]=temp.address[i];
		compressed.count[countIndex]=1;
		while(i+1<temp.last_page_size && temp.address[i]==temp.address[i+1]){
			compressed.count[countIndex]++;
			i++;
		}
		countIndex++;
	}
	compressed.size=countIndex;
	compressed.data=realloc(tempString,countIndex);

	return compressed;
}


//Calculates the relative output position for the buffer object.
int calculateOutputPosition(struct buffer temp){
	int position=0;
	// Step 1: Find the relative position of the buffer object
	//step 1: Find the relative file position of the buffer object.
	for(int i=0;i<temp.file_number;i++){
		position+=pages_per_file[i];
	}
	// Step 2: Find the relative postion of the page
	position+=temp.page_number;
	return position;	
}


// Consumer thread to start compression of memory for file in the 'buf' queue
void *consumer(){
	do{
		pthread_mutex_lock(&lock);
		while(q_size==0 && isComplete==0){
		    pthread_cond_signal(&empty);
			pthread_cond_wait(&fill,&lock); 
		}
		if(isComplete==1 && q_size==0){ 
			pthread_mutex_unlock(&lock);
			return NULL;
		}
		struct buffer temp=get();
		if(isComplete==0){
		    pthread_cond_signal(&empty);
		}	
		pthread_mutex_unlock(&lock);
		int position=calculateOutputPosition(temp);
		out[position]=RLECompress(temp);
	}while(!(isComplete==1 && q_size==0));
	return NULL;
}

/*					Main Stuff									  */

void printOutput(){
	char* finalOutput=malloc(total_pages*page_size*(sizeof(int)+sizeof(char)));
    char* init=finalOutput; 
    for(int i=0;i<total_pages;i++){
		if(i<total_pages-1){
			if(out[i].data[out[i].size-1]==out[i+1].data[0]){
				out[i+1].count[0]+=out[i].count[out[i].size-1];
				out[i].size--;
			}
		}
		
		for(int j=0;j<out[i].size;j++){
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


void freeMemory(){
	free(pages_per_file);
	for(int i=0;i<total_pages;i++){
		free(out[i].data);
		free(out[i].count);
	}
	free(out);
}