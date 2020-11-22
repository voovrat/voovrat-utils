#ifndef LINALG_H
#define LINALG_H

#include <vector>
#include <stddef.h> // size_t 

namespace linalg {


//  npow : x^n, n - integer 
// theoretically we can do better (like log(n) multiplications)
// but in out applications usually n<=2.. maybe will be used for n<7
// so, complexity of writing is too much higher than possible gain 
 double npow( double x, size_t n );


/// solve system of linear equations with gauss elimination method 
/// @param A : n x n  non-singular matrix
/// @param b : n x 1  vector of rhs values
/// @param x : n x 1  output 

// adopted from here : https://martin-thoma.com/solving-linear-equations-with-gaussian-elimination/

// A and b are passed by value cause they are modified inside 
void gauss_solve( std::vector< std::vector<double> > A
                , std::vector<double> b
                , std::vector<double> & x  // out 
                );

// * LU Decomposition. adopted wikipedia code : https://en.wikipedia.org/wiki/LU_decomposition

 // * INPUT: A - array of pointers to rows of a square matrix having dimension N
 // *       Tol - small tolerance number to detect failure when the matrix is near degenerate
 // * OUTPUT: Matrix A is changed, it contains both matrices L-E and U as A=(L-E)+U such that P*A=L*U.
 // *        The permutation matrix is not stored as a matrix, but in an integer vector P of size N+1 
 // *        containing column indexes where the permutation matrix has "1". The last element P[N]=S+N, 
 // *        where S is the number of row exchanges needed for determinant computation, det(P)=(-1)^S    

 // * RETURN: true if everything OK, false if the matrix is singular 

bool lup_decompose( std::vector< std::vector<double> > & A // inout
                  , std::vector<int> & P                   // out 
                  , double Tol
                  );

 // * INPUT: A,P filled in LUPDecompose; b - rhs vector; N - dimension
 // * OUTPUT: x - solution vector of A*x=b
 // *
void lup_solve( const std::vector< std::vector<double> > & A
              , const std::vector<int> & P 
              , const std::vector<double> & b
              , std::vector<double> & x   //   out
              );

 // * INPUT: A,P filled in LUPDecompose; N - dimension
 // * OUTPUT: invA is the inverse of the initial matrix
 // *
void lup_invert( const std::vector< std::vector<double> > & A
               , const std::vector<int> & P
               , std::vector< std::vector<double> > & invA  // out 
               );
 
 // * INPUT: A,P filled in LUPDecompose; N - dimension. 
 // * OUTPUT: Function returns the determinant of the initial matrix
 // *
double lup_determinant( const std::vector< std::vector<double> > & A
                      , const std::vector<int> & P ) ;
 
}



#endif