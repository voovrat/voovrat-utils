#include <time.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

main(int argc,char *argv[])
{
 clockid_t clockid;
 struct timespec tp;
 time_t tim;
 unsigned int rnd;
 

 clock_getcpuclockid( getpid(), &clockid );
 clock_gettime(clockid, &tp);
 
 time(&tim);

// printf("%ld.%ld -- %ld\n",tp.tv_sec,tp.tv_nsec,tim);
 
 srand( tim + tp.tv_nsec);

 rnd = (unsigned int)rand();
 if( argc > 1 ) 
 {
    unsigned int modulo = atoi(argv[1]);
    rnd = rnd % modulo;
 }

 printf("%d\n",rnd);

 return 0;

}

