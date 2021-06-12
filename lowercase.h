#ifndef LOWERCASE_H
#define LOWERCASE_H

#include <string>
#include <algorithm>
#include <cctype>

inline std::string lowercase( std::string && s )
{
   std::transform(s.begin(), s.end(), s.begin(), ::tolower );
   return s;
} 

inline std::string lowercase( const std::string & s)
{
  std::string r = s;
  return lowercase(std::move(r));
}

#endif
