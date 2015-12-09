#include <stdio.h>
#include <string.h>

main(int argc,char *argv[])
{
  char *cmd;
  int state = 0;
  int currc = 0;
  char prevc;
  int len;
  int brace_count = 0;
  int i;
  int slash_count = 0;

  if(argc<2)
  {
     puts("Usage: remove_command cmd  [replacement]");
     puts(" removes from stdin the word 'cmd' and everything which is in brace {} after it");
     return 0;
  }

  cmd = argv[1];
  len = strlen(cmd);

  while(!feof(stdin))
  {
     char c = getchar();
     if(c<0) break;

     switch(state)
     {
        case 0: 
               if(currc<len && c==cmd[currc]) 
                   currc++;
                else
                { 
                   for(i=0;i<currc;i++) putchar(cmd[i]);  // what is in buffer
                   putchar(c);
                   currc=0;
                }
		if(currc == len) 
                { 
                  state = 1; currc=0;
                  if(argc>2) printf("%s",argv[2]);                    
                }
                break;

        case 1: if( c == '{'  ) 
                {
                   brace_count = 1; 
                   state=2;
                }
                else if( c != ' ' && c != '\t' ) {putchar(c); state=0;}

                break;

        case 2: if ( c == '{' && ((slash_count&1) == 0) ) brace_count++;
                if ( c == '}' && ((slash_count&1) == 0) ) brace_count--;
                if ( brace_count == 0 ) state = 0; 
                if ( c == '\\' ) 
                   slash_count++;
                else
                   slash_count = 0;

                break; 
     };//case state
   
     prevc = c;
  } // while eof
  

}
