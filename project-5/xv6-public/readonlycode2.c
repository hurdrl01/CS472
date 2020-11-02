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

  if (munprotect((void *)p, 1) == -1) {
  	printf(1, "munprotect call failed\n");
  } else {
  	printf(1, "munprotect call succeeded\n");
  }

  *p = value;
  printf(1, "%x\n", *p); 	

  p = (int *)0x1001;
  if (mprotect((void *)p, 1) == -1) {
    printf(1, "mprotect call failed: page aligned\n");
  } else {
    printf(1, "mprotect call succeeded\n");
  }

  p = (int *)0x1001;
  if (munprotect((void *)p, 1) == -1) {
    printf(1, "munprotect call failed: page aligned\n");
  } else {
    printf(1, "munprotect call succeeded\n");
  }

  p = (int *)0x1000;
  if (mprotect((void *)p, 4) == -1) {
    printf(1, "mprotect call failed: page length\n");
  } else {
    printf(1, "mprotect call succeeded\n");
  }

  p = (int *)0x1000;
  if (munprotect((void *)p, 4) == -1) {
    printf(1, "munprotect call failed: page length\n");
  } else {
    printf(1, "munprotect call succeeded\n");
  }

  exit();
}
