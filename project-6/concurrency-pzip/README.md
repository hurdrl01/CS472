# Project 5 - Introduction to xv6 Virtual Memory   
## Author(s): Ryan Hurd & Vinamra Munot<br/>
Professor: Dr. Chen<br/>
Course: CS 472 - Operating System Design<br/>
Due Date: November 4, 2020 11:59 PM<br/>

## Project Changes 
We used a paired programming method, we programmed on one machine sharing ideas and code until we arrived at a finished product
### For Part One: <br/>
**mmap()** creates a new mapping in the virtual address space of the calling process. The starting address for the new mapping is specified in addr. The length argument specifies the length of the mapping (which must be greater than 0). If addr is NULL, then the kernel chooses the (page-aligned) address at which to create the mapping; this is the most portable method of creating a new mapping. If addr is not NULL, then the kernel takes it as a hint about where to place the mapping; on Linux, the kernel will pick a nearby page boundary (but always above or equal to the value specified by /proc/sys/vm/mmap_min_addr) and attempt to create the mapping there. If another mapping already exists there, the kernel picks a new address that may or may not depend on the hint. The address of the new mapping is returned as the result of the call.

