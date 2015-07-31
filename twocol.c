#include <stdio.h>
#include <string.h>

main(int argc,char *argv[])
{
if(argc<=2) 
{
	printf("Prints two files in columns one near another\n Usage: twocol File1 File2\n");
	return 1;
}

FILE *f1,*f2;

f1 = fopen(argv[1],"r");
if(!f1) 
{
	printf("cannot open %s\n",argv[1]);
	return 2;
}
f2 = fopen(argv[2],"r");
if(!f2)
{
	printf("cannot open %s\n",argv[2]);
	return 2;
}


char s1[256],s2[256];
char *r1,*r2;

while(!feof(f1) && !feof(f2))
{
	fgets(	s1,	//char *s, 
		256,	//int size, 
		f1	//FILE *stream
		);	

	fgets(	s2,	//char *s, 
		256,	//int size, 
		f2	//FILE *stream
		);	

	s1[strlen(s1)-1] = 0;
	s2[strlen(s2)-1]=0;	
	if(!feof(f1) && !feof(f2))
		printf("%s\t%s\n",s1,s2);
}
return 0;

}
