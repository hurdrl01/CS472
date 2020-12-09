# Project 6 - Parallel Zip <br/> 
## Author(s): Ryan Hurd & Vinamra Munot <br/>
Professor: Dr. Chen<br/>
Course: CS 472 - Operating System Design <br/>
Due Date: December 9, 2020 11:59 PM<br/>

## For Part Three: Consumer and Producer <br/>

Basically consumer comes in and checks if there are any tasks. Producer creates the tasks in the queue.
The queue data structure:
- Queue operations:
    - enqueue
    - dequeue
    - init
    - clean 

```c

/* job description */
typedef struct job {
    char *read_buffer;
    int read_size; 
    char *result_buffer;
    int result_size;
    struct job *next;
} zip_job;

/* linkied list queue */
typedef struct queue {
    zip_job *head;
    zip_job *tail;
    zip_job *current; // used by consumers to indicate the current running job or the dummy node 
    pthread_cond_t fill; // indicate that the queue is not empty
    int count;   // number of available unrun jobs in queue 
    pthread_mutex_t lock; 
    int done;   // indicate that producer is done 
} zip_queue;
```
We have used the above data structures and then used the printOutput to print the result. Also used page_size to be as 4096. 

```c
void *consumer(){
	do{
		pthread_mutex_lock(&lock);
		while(q_size==0 && isComplete==0){
		    pthread_cond_signal(&empty);
			pthread_cond_wait(&fill,&lock); //call the producer to start filling the queue.
		}
		if(isComplete==1 && q_size==0){ //If producer is done mapping and there's nothing left in the queue.
			pthread_mutex_unlock(&lock);
			return NULL;
		}
		struct buffer temp=get();
		if(isComplete==0){
		    pthread_cond_signal(&empty);
		}	
		pthread_mutex_unlock(&lock);
		//Output position calculation
		int position=calculateOutputPosition(temp);
		out[position]=RLECompress(temp);
	}while(!(isComplete==1 && q_size==0));
	return NULL;
}
```

```c
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
 
		pages_in_file=(sb.st_size/page_size);
		if(((double)sb.st_size/page_size)>pages_in_file){ 
			pages_in_file+=1;
			last_page_size=sb.st_size%page_size;
		}
		else{ //Page alligned
			last_page_size=page_size;
		}
		total_pages+=pages_in_file;
		pages_per_file[i]=pages_in_file;

		map = mmap(NULL, sb.st_size, PROT_READ, MAP_SHARED, file, 0);									  
		if (map == MAP_FAILED) { //yikes #3,possibly due to no memory? --unmap needed then?
			close(file);
			printf("Error mmapping the file\n");
			exit(1);
    	}	
    	
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

	isComplete=1; 
	pthread_cond_broadcast(&fill); 
	return 0;
}
```

The above code is what we used for producer and consumer