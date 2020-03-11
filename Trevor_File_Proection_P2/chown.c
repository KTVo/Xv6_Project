//comments for chown
// testing
//
//
//   
#include "fs.h"
#include "stdio.h"
#include "stdlib.h"
#include "types.h"
#include "user.h"
#include "fcnl.h"
#include "stat.h"
#include "defs.h"
#include "file.h"


// Sets the user UID for the target specified by pathname.
int
main(int argc, char *argv[])
{
  if(argc > 2)
  {
    if(atoi(argv[1]) >= 0)
      if(chown(argv[2], atoi(argv[1])) < 0)
        printf(1, "chown %s failed\n", argv[2]);
       else
        printf(1, "Updating owner id...\n");
    else
      printf(1, "Invalid argument(s) for chown...\n");
  }
  exit();
}
