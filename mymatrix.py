
def disp(A):
  for i in range(nlin(A)):
    s=''
    for j in range(ncol(A)):
      s+='%20.3f' % A[i][j]
    print s

def readlines(fname):
  f = open(fname)
  lines = f.readlines()
  f.close()
  return [ l[:-1] for l in lines ]


def getMatrix(lines):
  m=len(lines)
  matrix=[]
  for l in lines:
     matrix.append( [ float(w) for w in l.split() ])
  return matrix


def mmul(A,B):  # matrix multiplication
  C = []
  for i in range(nlin(A)):
    C.append([])
    for j in range(ncol(B)):
      S = 0
      for k in range(ncol(A)):
        S += A[i][k] * B[k][j]
      C[i].append(S)
  return C   

def mmulx( Alist ):
  return reduce( mmul, Alist) 

"""
  minor M(I,J), I,J = ranges
"""
def submatrix(M,I,J):
  S = []
  for i in I:
    S.append( [ M[i][j] for j in J ])
  return S

def madd(A,B):
  C = []
  for i in range(nlin(A)):
    C.append( [ A[i][j] + B[i][j] for j in range(ncol(A)) ]  )
  return C

def maddx(Alist):
  return reduce( madd, Alist )

def msub(A,B):
  C = []
  for i in range(nlin(A)):
    C.append( [ A[i][j] - B[i][j] for j in range(ncol(A)) ]  )
  return C


def mmulsc(alpha,A):
  B=[]
  for i in range(nlin(A)):
    B.append( alpha*a for a in A[i] )
  return B


def transp(matrix):
  n = len(matrix[0])
  m = len(matrix)
  tlines = [ [] for j in range(n) ]
  for i in range(m):
    for j in range(n):
      tlines[j].append(matrix[i][j])
  return tlines
  

def colcat(Alist):
  return  reduce( lambda A,B:  transp( transp(A) + transp(B)) , Alist ) 

def nlin(A):
  return len(A)

def ncol(A):
  return len(A[0])

def colvec(lst):
  return [ [a] for a in lst]

def linvec(lst):
  return [[lst]]

def linrep(vec,N):
  return [ vec for i in range(N) ]
