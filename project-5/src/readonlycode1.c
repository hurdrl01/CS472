#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"

int
main(int argc, char *argv[])
{
  int *p = (int *)0x1000; 			// 0x1000 is just the address of code
  int value = *p;
  
  *p = value;

  if (mprotect((void *)p, 1) == -1) {
  	printf(1, "mprotect call failed\n");
  } else {
  	printf(1, "mprotect call succeeded\n");
  }

  *p = value;

  if (munprotect((void *)p, 1) == -1) {
  	printf(1, "munprotect call failed\n");
  } else {
  	printf(1, "munprotect call succeeded\n");
  }

  printf(1, "%x\n", *p); 	

  exit();
}
