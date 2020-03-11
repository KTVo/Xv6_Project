/*
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
*/


#include "param.h"
#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"
#include "syscall.h"
#include "traps.h"
#include "memlayout.h"



int
main(void)
{
 uint uid, gid, ppid;

 uid = getuid();
 printf(2, "1 - Current UID is: %d\n", uid);
 printf(2, "2 - Setting UID to 100\n");
 setuid(100);
 uid = getuid();
 printf(2, "3 - Current UID is: %d\n", uid);
 gid = getgid();
 printf(2, "4 - Current GID is: %d\n", gid);
 printf(2, "5 - Setting GID to 100\n");
 setgid(100);
 gid = getgid();
 printf(2, "6 - Current GID is: %d\n", gid);
 ppid = getppid();
 printf(2, "7 - My parent process is: %d\n", ppid);
 printf(2, "Done!\n");
 exit();
}

