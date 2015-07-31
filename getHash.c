#include <stdio.h>

main()
{
int S=0;

while(!feof(stdin)) S+=getchar();

printf("%d\n",S);

return 0;


}
