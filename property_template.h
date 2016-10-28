#ifndef PROPERTY_TEMPLATE_H
#define PROPERTY_TEMPLATE_H


// Volodymyr P Sergiievskyi, aka voov.rat 28.10.2016

// template to use the "property" functionality (like in borland or C#)
// see example code in the end of file
//
//  what you would need to define:
//    - in your Class property<Class,Type> variable;  where type is a type of your property
//    - define usual getters/setters (like Type getX() const and void setX( Type x)
//    - In the constructor initialize your property like 
//             : x(  this, getX,  setX )
//
//  See the minimal example in the end of the file
//



template< class Base, class Type > // Base is the type of base class, Type is the type of the property
class property {
public:

	
	typedef Type (Base::*GetFn)() const ;
	typedef void (Base::*SetFn)(Type );

	Base *obj;
	GetFn get;
        SetFn set;



	property ( Base *obj, GetFn get = NULL, SetFn set = NULL )  
	{
		this->obj = obj;
		this->get = get;
		this->set = set;
	}



	operator Type() const {
	{
           if( obj && get ) 
		   return (obj->*get)();
	   else
		   throw "property cannot be read";
	}


	}

	Type operator=( Type y) const {
	   if( obj && set ) {
     		(obj->*set)(y);
		return y;
	   }
	   else
		 throw "property cannot be set";
	}
};



/*  Example code

 #include <iostream>

#include "property_template.h"

class B {

  public:

    property<B,double> z;
    
    double getZ() const {return 3.333; }

    void setZ( double X) 
    { 	     
       std::cout<<" B::setZ with X="<<X<<" called\n";
    }

    B() : z( this,  getZ, setZ )  {}

};



main() {


B b;
double x = b.z + 1;


std::cout << "x = "<<x<<"b.z="<< b.z << std::endl;
b.z = 13;

	
return 0;

}


 
OUTPUT:

x = 4.333b.z=3.333
 B::setZ with X=13 called
 
 * */



#endif

