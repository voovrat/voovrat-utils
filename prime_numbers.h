#ifndef PRIME_NUMBERS_H
#define PRIME_NUMBERS_H

#include <vector>

class TPrimeNumbers
{
	std::vector<int> mPrimeList;
	TPrimeNumbers();

	static TPrimeNumbers & instance() 
	{
		static TPrimeNumbers inst;
		return inst;
	}

public:

	static const std::vector<int>  & PrimeList() { return instance().mPrimeList; }

};


#endif