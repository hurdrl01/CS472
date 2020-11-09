#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"

int
main(int argc, char *argv[])
{
  int *p = 0; 			// 0 is just NULL in C

  printf(1, "%x\n", *p); 	// deref NULL pointer 

  exit();
}
