# Project 6 - Parallel Zip <br/> 
## Author(s): Ryan Hurd & Vinamra Munot <br/>
Professor: Dr. Chen<br/>
Course: CS 472 - Operating System Design <br/>
Due Date: November 18, 2020 11:59 PM<br/>

We used a paired programming method, we programmed on one machine sharing ideas and code until we arrived at a finished product
## For Part One: Single thread using mmap() and write() <br/>
### **mmap()** <br/> 
Creates a new mapping in the virtual address space of the calling process. The starting address for the new mapping is specified in addr. The length argument specifies the length of the mapping (which must be greater than 0). If addr is NULL, then the kernel chooses the (page-aligned) address at which to create the mapping; this is the most portable method of creating a new mapping. If addr is not NULL, then the kernel takes it as a hint about where to place the mapping; on Linux, the kernel will pick a nearby page boundary (but always above or equal to the value specified by /proc/sys/vm/mmap_min_addr) and attempt to create the mapping there. If another mapping already exists there, the kernel picks a new address that may or may not depend on the hint. The address of the new mapping is returned as the result of the call.<br/>

 ### **write()** <br/> 
 Writes up to count bytes from the buffer starting at buf to the file referred to by the file descriptor fd.<br/>
 
Using multiple file descriptors, we were able to iterate through the address buffer for all the files and write out the result into the standard output.<br/>