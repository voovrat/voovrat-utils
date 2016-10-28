#include "read_lines.h"

#include <string>
#include <iostream>
#include <list>
#include <set>

#include <string.h>
#include <ctype.h>

#include "stdio.h"

using namespace std;


string int2string(int n, const char *format)
{
   char str[256];
   sprintf(str,format,n);

   string s = str;

   return s;
}


bool string_replace( std::string &s, const char *pattern, const char *data)
{
   const std::string spattern(pattern);

   int pos = s.find(spattern);
   if(pos<0) return false;

   s.replace(pos,spattern.length(),data);

   return true;
}


string modified_string( const string &str,  int (*modificator)(int) )
{
   char *buffer;
   buffer = new char[str.length() + 1];

   for(int i=0;i< str.length(); i++)
      buffer[i] = modificator(str[i]);

   buffer[str.length()] = '\0';

   string s(buffer);
   delete buffer;
   return s;
}

string upcase(const string &str)
{
   return modified_string( str, toupper );
}

string locase( const string &str)
{
   return modified_string( str, tolower );
}


template<typename T>
inline void copy(vector<T> &dst, const list<T> &src)
{
   typename list<T>::const_iterator it;
   
   dst.reserve(src.size());
   dst.clear();
   for(it=src.begin(); it != src.end(); it++)
      dst.push_back(*it);
  
}


string read_file( istream &fs)  // data will be allocated
{
    char *file_chars;
  
    list<char> file_chars_list;
    
    // so strange and long... but what if fs is NOT a file, but a pipe? it has no size, so it cannot be simply copied to memory
    while(!fs.eof())
    {
       int c= fs.get();
       if(c>0) file_chars_list.push_back(c); else break;
    }

    int N = file_chars_list.size();
    file_chars = new char[N+2];

    list<char>::iterator it;
    int prev_pos = 0;
    int i,cnt;
    cnt=0;
    for(it = file_chars_list.begin();  it!=file_chars_list.end(); it++,cnt++)
    {
          file_chars[cnt] = *it;
    }
    file_chars[cnt]=0;
   
//   cout<<"FILE CHARS: N="<<N<<" cnt="<<cnt<<endl;

   string s(file_chars);

  // printf("FILE CHARS PTR %0x %0x:",(int)file_chars,(int)s.c_str());
  // file_chars[3]='a';
  // s = "HELLO";
   delete [] file_chars; //--> don't delete. It seems, that the string constructor does not copy the content from file_chars
   return s;
}


void read_lines( istream &fs, vector<string> &lines)
{
   set<char> delims;
   set<char> omit;

   delims.insert('\n');
   char i;
   for(i=0;i<32;i++) 
     if(i!='\n' && i!='\t') omit.insert(i);

   read_lines(fs,lines, delims, omit );
}


void read_lines( istream &fs,vector<string> &out_lines,const set<char> &delims, const set<char> &omit)
{
    char *file_chars;

    list<char> file_chars_list;
    
    list<string> lines;
    // so strange and long... but what if fs is NOT a file, but a pipe? it has no size, so it cannot be simply copied to memory
    while(!fs.eof())
    {
       int c= fs.get();
       if(c>0) file_chars_list.push_back(c); else break;
    }

    int N = file_chars_list.size();
    file_chars = new char[N+2];

    list<char>::iterator it;
    int prev_pos = 0;
    int i,cnt;
    cnt=0;
    i=0;
    for(it = file_chars_list.begin();  it!=file_chars_list.end(); it++,cnt++)
    {
         if( omit.find(*it) != omit.end()) continue;

 
         if(delims.find(*it) != delims.end() ||  cnt == N-1 ) 
         {   file_chars[i] = 0; 
             std::string s(file_chars + prev_pos); 
             lines.push_back(s);
             prev_pos = i+1;
         }
         else
             file_chars[i] = *it;


         i++;
    }
   
    delete file_chars;

    copy(out_lines, lines);
}


void split_words(const string &str,vector<string> &words)
{
    set<char> delim;
    delim.insert(' ');
    delim.insert('\t');

    split_words(str,words,delim);
}


void split_words(const string &str, vector<string> &out_words,const set<char> &delim)
{
   char *str_chars;

   list<string> words;

   int N = str.length();

   str_chars = new char[ N+1 ];
   strcpy(str_chars, str.c_str());

   words.clear();

   int i;
   int prev_pos = 0;
   for(i=0;i<=N;i++)
   {
      if(delim.find(str_chars[i]) != delim.end() || i==N )
      {
         str_chars[i] = 0;
         if( i == prev_pos ) 
             prev_pos++;
         else {
             string s(str_chars + prev_pos);
             words.push_back(s);
             prev_pos = i+1;
         }//else

      }//delim

   }//for

   copy(out_words,words);

   delete str_chars;
}

/*
main()
{
   set<char> delims;
   set<char> omit;
    
   delims.insert('\n');
   omit.insert('X');
  
   list<string> lines;

   read_lines( cin, lines);

   cout<<endl;
   list<string>::iterator it;
   


   list<string> words;
   for(it=lines.begin(); it!=lines.end(); it++)
   {
       split_words(*it,words);

       cout<<"AA:"<<(*it)<<endl;
       list<string>::iterator iit;
       for(iit=words.begin(); iit!=words.end(); iit++)
       {
           cout<<"   BB:"<<(*iit)<<endl;
       }
   }
}
*/

