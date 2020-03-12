/*
 * Filename: chmod.c
 *
*/
#include "types.h"
#include "stat.h"
#include "user.h"

    int
    main(int argc, char *argv[])
    {
        if(argc < 3){
        	printf(2,"Usage: chmod <mode> <filepath>\n");
        	exit();
        }
        int fd;
        struct stat st;
        char * path = argv[2];
        if((fd = open(path, 0)) < 0) {
            printf(2, "chmod: cannot open %s\n", path);
            exit();
        }
        if(fstat(fd, &st) < 0) {
            printf(2, "chmod: cannot stat %s\n", path);
            close(fd);
            exit();
        }

	int mode = 0;
  /*
        int mode = st.mode;

        char *c = argv[1];
        if(strlen(c)<3){
        	printf(2, "mode should be 3 digit\n");
        }
        if(c[0]<'0'||c[0]>'9'||c[1]<'0'||c[1]>'9'||c[2]<'0'||c[2]>'9'){
        	printf(2,"mode should be number %s\n",c);
        }
        close(fd);
        //printf(1,"%x\n",st.mode);
        mode = (c[0] - '0') * 256 + (c[1] - '0') * 16 + c[2] - '0';
        //printf(1,"change to %x\n",mode);
    
*/    
	chmod(path, mode);
        exit();
    }



