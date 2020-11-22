//USECSM(NO)
#pragma hdrstop

#include "linalg.h"

#include <math.h>
#include <algorithm>    // std::swap


double linalg::npow( double x, size_t n )
{
   double xn = 1;
   while(n--)  xn *= x;
   return xn; 
}


// based on code by  Martin Thoma, taken from here https://martin-thoma.com/solving-linear-equations-with-gaussian-elimination/
void linalg::gauss_solve( std::vector< std::vector<double> > A
                , std::vector<double>  b
                , std::vector<double> & x  // out 
                )
{
    int i,j,k;
    int n = A.size();

    for ( i=0; i<n; i++)
    {
        // Search for maximum in this column
        double maxEl = fabs(A[i][i]);
        int maxRow = i;
        for ( k=i+1; k<n; k++) 
        {
            if (fabs(A[k][i]) > maxEl) 
            {
                maxEl = fabs(A[k][i]);
                maxRow = k;
            }
        }

        // Swap maximum row with current row (column by column)
        std::swap( A[maxRow], A[i]);
        std::swap( b[maxRow], b[i]);

        // Make all rows below this one 0 in current column
        for ( k=i+1; k<n; k++) 
        {
            double c = -A[k][i]/A[i][i];
            for ( j=i; j<n; j++) 
                A[k][j] += c * A[i][j];
            
            b[k] += c * b[i]; 
        }
    }

    // Solve equation Ax=b for an upper triangular matrix A
    x.resize(n);
    for ( i=n-1; i>=0; i--) 
    {
        x[i] = b[i]/A[i][i];
        for ( k=i-1;  k>=0;  k--) 
            b[k] -= A[k][i] * x[i];
    }
}


 // ****************  LU  **********************

 // taken from wikipedia : https://en.wikipedia.org/wiki/LU_decomposition
 //   pointers changed to vectors, swaps done with std::swap 

 // * INPUT: A - array of vectorss to rows of a square matrix having dimension N
 // *        Tol - small tolerance number to detect failure when the matrix is near degenerate
 // * OUTPUT: Matrix A is changed, it contains both matrices L-E and U as A=(L-E)+U such that P*A=L*U.
 // *        The permutation matrix is not stored as a matrix, but in an integer vector P of size N+1 
 // *        containing column indexes where the permutation matrix has "1". The last element P[N]=S+N, 
 // *        where S is the number of row exchanges needed for determinant computation, det(P)=(-1)^S    

bool linalg::lup_decompose( std::vector< std::vector<double> > & A // inout
                          , std::vector<int> & P  // out 
                          , double Tol
                          )
{
    int i, j, k, imax; 
    double maxA, absA;

    int N = A.size();
    P.resize(N+1);

    for (i = 0; i <= N; i++)
        P[i] = i; //Unit permutation matrix, P[N] initialized with N

    for (i = 0; i < N; i++) 
    {
        maxA = 0.0;
        imax = i;

        for (k = i; k < N; k++)
        {
            if ((absA = fabs(A[k][i])) > maxA) 
            { 
                maxA = absA;
                imax = k;
            }
        }

        if (maxA < Tol) return false; //failure, matrix is degenerate

        if (imax != i) 
        {
            //pivoting rows of A
            std::swap( P[i], P[imax] );
            std::swap( A[i], A[imax] );
            //counting pivots starting from N (for determinant)
            P[N]++;
        }

        for (j = i+1; j < N; j++ )
        {
            A[j][i] /= A[i][i];

            for (k = i + 1; k < N; k++)
                A[j][k] -= A[j][i] * A[i][k];
        }
    } // i 

    return true;  //decomposition done 
}


 // * INPUT: A,P filled in LUPDecompose; b - rhs vector; N - dimension
 // * OUTPUT: x - solution vector of A*x=b

void linalg::lup_solve( const std::vector< std::vector<double> > & A
                      , const std::vector<int> & P 
                      , const std::vector<double> & b
                      , std::vector<double> & x   //   out
                      )
{
    int i,k;
    int N = A.size();

    x.resize(N);

    for ( i=0; i<N; i++) 
    {
        x[i] = b[P[i]];

        for ( k=0; k < i; k++)
            x[i] -= A[i][k] * x[k];
    }

    for ( i = N-1; i >= 0; i--)
    {
        for ( k = i+1; k < N; k++)
            x[i] -= A[i][k] * x[k];

        x[i] = x[i] / A[i][i];
    }
}

 // * INPUT: A,P filled in LUPDecompose; N - dimension
 // * OUTPUT: IA is the inverse of the initial matrix
 
void linalg::lup_invert( const std::vector< std::vector<double> > & A
                       , const std::vector<int> & P
                       , std::vector< std::vector<double> > & invA  // out 
                       ) 
{
    int i,j,k;

    int N = A.size();
    invA.assign(N, A[0] );
  
    for ( j=0; j<N; j++)
    {
        for ( i=0; i<N; i++)
        {
            if (P[i] == j) 
                invA[i][j] = 1.0;
            else
                invA[i][j] = 0.0;

            for ( k=0; k<i; k++)
                invA[i][j] -= A[i][k] * invA[k][j];
        }

        for ( i=N-1; i >= 0; i--)
        {
            for ( k=i+1; k < N; k++)
                invA[i][j] -= A[i][k] * invA[k][j];

            invA[i][j] = invA[i][j] / A[i][i];
        }
    } // j 
}

 // * INPUT: A,P filled in LUPDecompose; N - dimension. 
 // * OUTPUT: Function returns the determinant of the initial matrix
 
double linalg::lup_determinant( const std::vector< std::vector<double> > & A
                              , const std::vector<int> & P ) 
 {
    int N  = A.size();
    double det = A[0][0];

    for (int i = 1; i < N; i++)
        det *= A[i][i];

    if ((P[N] - N) % 2 == 0)
        return det; 
    else
        return -det;
}

