# Project 5 - Introduction to xv6 Virtual Memory   
## Author(s): Ryan Hurd & Vinamra Munot<br/>
Professor: Dr. Chen<br/>
Course: CS 472 - Operating System Design<br/>
Due Date: November 4, 2020 11:59 PM<br/>

## Project Changes 
### We used a paired programming method, we programmed on one machine sharing ideas and code until we arrived at a finished product
exec.c - Changed page size to the proper value.<br/>
Makefile - Added user programs, extras, required flag, and updated CPU count.<br/>
null1.c - File for testing.<br/>
null2.c - File for testing.<br/>
readonlycode1.c - File for testing.<br/>
readonlycode2.c - File for testing.<br/>
syscall.c - Add the system calls for mprotect and munprotect.<br/>
syscall.h - Add the system calls and number for mprotect and munprotect.<br/>
sysproc.c - Added implementation of mprotect and munprotect.<br/>
vm.c - Implementation of mprotect and munprotect.<br/>

### For Part One: <br/>
We  changed$ (LD) $ (LDFLAGS) -N -e main -Ttext 0 -o $@ $^ to change 0 to 0x1000 because the address doesn't start from 0 anymore for the page table.<br/>
In exec.c we changed the sz variables to PGSIZE which is by default 4096 to load the next page instead of being 0.<br/>
Within vm.c, we changed the for loop in `copyuvm` to have i = pgsize. added another `if and else` statement where it checks if the addr is equal to 0 for fetchint, then added an extra or conditional in line 70 of syscall.c to (uint)i == 0 to check the entry is starting from zero or not.<br/>

### For Part Two:<br/>
Defined both functions in syscall.h.<br/>
Inside syscall.c, added declarations for both mprotect and munprotect.<br/>
In sysproc.c, added functions for both mprotect and munprotect, check conditional then return -1 if argint < 0.<br/>
Added system calls to user.h for mprotect and munprotect and same for usys.S.<br/>
In vm.c, function mprotect is checking if the length is less than or greater than the length of a page, if it is then prints out an error and returns -1. Then, checks if the page is aligned, if not it returns -1. Then the function loops through each page getting the PTE in the current process's pgdir. Then it clears the writing bit making the page not writable. after the loop finishes, it then reloads the control register with the address of the page directory.<br/>
The munprotect does the opposite to the above function in which it sets the writing bit rather than clearing it making the page both readable and writable.<br/>