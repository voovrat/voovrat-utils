#ifndef READ_LINES_H
#define READ_LINES_H

#include <istream>
#include <vector>
#include <string>
#include <set>

std::string int2string(int n,const char *format = "%d");

bool string_replace( std::string &s, const char *pattern, const char *data);

std::string read_file( std::istream &fs);  // data will be allocated

// read the istream fs until eof and put the lines into list lines (output argument) 
void read_lines( std::istream &fs,std::vector<std::string> &lines,const std::set<char> &delims, const std::set<char> &omit);

// the same with defaults: delim='\n', omit = \0x00...\0x1F without \n \t
void read_lines( std::istream &fs, std::vector<std::string> &lines);


void split_words(const std::string &str,std::vector<std::string> &words);

//split words using the given set of delimeters
void split_words(const std::string &str, std::vector<std::string> &words,const std::set<char> &delim);



std::string modified_string( const std::string &str,  int (*modificator)(int) );

std::string upcase(const std::string &str);
std::string locase(const std::string &str);




#endif
