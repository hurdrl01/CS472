# Project 4 - Lottery Scheduling in XV6
Author: Ryan Hurd
Class: CS472 - Operating System Design
Professor: Dr. Chen
Date: 10/06/2020


Project 4 consists of a lottery scheduler in XV6  which allows tickets to be used to schedule process using only one CPU at a time.

The files changed in this implementation vs. the source for XV6 have been:

Makefile - Change CPU number to 1, 
	Added user program spin to list, and
	Added spin.c to EXTRA programs.
defs.h - Add function definitions so other files can access functions.
proc.c - Initialize scheduling variables (tickets, ticks, etc.),
	Changed allocproc() to use our scheduling variables appropriately,
	Set fork() to use scheduling variables properly,
	Implemented scheduler() to keep track of global tickets,
	Have scheduler() select a random ticket from all of the global tickets,
	Implementation of settickets(), and 
	Implementation of getpinfo().
syscall.c - In argstr() provide info for new system calls settickets() and getpinfo().
syscall.h - Add system calls settickets() and getpinfo() with correspondy system call number.
sysproc.c - Define system call function settickets() and getpinfo(), point to proper functions
user.h - Provide functions settickets() and getpinfo() headers.
usys.S - Script for using system calls, add system calls settickets() and getpinfo().
spin.c - main function, allowing
pstat.h - Provide pstat structure which gives the information related to scheduling a process 
	(tickets, inuse, ticks, etc.)
main.c - 