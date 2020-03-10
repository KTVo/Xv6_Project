//comment
//
//
//
/*
#include "stdio.h"
#include "stdlib.h"
#include "types.h"
#include "user.h"
#include "fcnl.h"
#include "stat.h"

int
main(int argc, char *argv[])
{
  if(argv[1] == NULL && argv[2] == NULL)
  {
    printf("\nError: argv[1] or argv[2] is a NULL.\n");
    return -1;
  }

  const int maxIndx = 4; //the max number of digits from mode

  int mode = atoi(argv[1]); //converts argv[1] string into an integer for mode

  int tempMode = mode;

  int digit[maxIndx];

  int
  while(tempMode > 0 && indx > 0 && indx < maxIndx)
  {
    int mod = tempMode % 10;

    digit[indx++] = mod;

    tempMode = tempMode / 10;
  }

  if(indx < maxIndx-1)
  {
    printf("\nError: The mode entered is under 4 digits.\n");
  }

  for(int i = 0; i < maxIndx; i++)
          printf("\n%d\n", digit[i]);
  exit();
}
*/
