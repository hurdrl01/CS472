#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"

int
main(int argc, char *argv[])
{
  const char *dir = 0;		// 0 is just NULL in C
  int *p = 0;

  mkdir(dir);
  pipe(p);

  exit();
}
