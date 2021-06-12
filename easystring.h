#ifndef EASYSTRING_STR_H
#define EASYSTRING_STR_H

#include <sstream>

namespace easystring { 

class Str {
  std::stringstream mSs;

public:

  Str( const char * s) {
    mSs << s;
  }

  Str( const Str & s)   {
    mSs << (const char *)s;
  }

 operator const char *() const {
    return mSs.str().c_str();
  }

  Str operator+=( const char * s)   {
     mSs << s;
     return *this;
  }


  template<class T>
  Str operator+=( T s)   {
     mSs << s;
     return *this;
  }

  template<class T>
  Str operator+( T s)   {
      Str nS(*this);
      nS += s;
      return nS;
  }

};

} // namespace

#endif
