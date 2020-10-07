# Project 4 - Lottery Scheduling in XV6
Author: Ryan Hurd
Class: CS472 - Operating System Design
Professor: Dr. Chen
Date: 10/06/2020


Project 4 consists of a lottery scheduler in XV6  which allows tickets to be used to schedule process using only one CPU at a time.

The files changed in this implementation vs. the source for XV6 have been:

Makefile - Change CPU number to 1, added user program spin to list, added spin.c to EXTRA programs.
defs.h - Add function definitions so other files can access functions
main.c - 
proc.c - Initialize scheduling variables (tickets, ticks, etc.),
	Changed allocproc() to use our scheduling variables appropriately,
	Set fork() to use scheduling variables properly,
	Implemented scheduler() to keep track of global tickets,
	Have scheduler() select a random ticket from all of the global tickets, and
	Implementation of settickets() and getpinfo()
syscall.c - 
syscall.h - 
sysproc.c - 
user.h - 
usys.S - 
spin.c - main function, allowing
pstat.h - 