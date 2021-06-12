#ifndef DO_SEQUENTIAL_H
#define DO_SEQUENTIAL_H

#include <functional>
#include <mutex>


void do_sequential( const std::function<void()> & fn )
{
	static std::mutex mu;
	std::lock_guard<std::mutex> lock(mu);

	fn();
}

#endif
