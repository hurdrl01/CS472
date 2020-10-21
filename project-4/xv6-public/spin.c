#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "pstat.h"

void printprocinfo() 
{
	struct pstat st;
	int j;

	if (getpinfo(&st) == -1) {
		printf(1, "cannot getpinfo!\n");
	} else {		
		for (j = 0; j < NPROC; j++) {
	        if (st.inuse[j] == 1 && st.pid[j] >= 3) {
	            printf(1, "tickets: %d \t pid: %d \t ticks-used: %d\n", st.tickets[j], st.pid[j], st.ticks[j]);
	        }
	    }
	}
}

int
main(int argc, char *argv[])
{
	int i;
	int x = 0;	

	printprocinfo();

	if (argc != 3) {
		printf(1, "please use: %s tickets counts\n", argv[0]);
		exit();
	}


	if (settickets(atoi(argv[1])) == -1) {
		printf(1, "cannot settickets!\n");
	}

	for(i = 1; i < atoi(argv[2]); i++)
		x += i;

	printprocinfo();

	exit();
	return 0;
}
