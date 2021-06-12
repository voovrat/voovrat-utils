function X = dist2xyz(D,n)
% X = dist2xyz(D,n)
% n - dimensionality

% in 1D everything is trivial: 2 points which lie on one line, one is zero
if n==1
  X = zeros(2,1);
  X(1) = 0; 
  X(2) = D(1,2);
  return
end

m = size(D,1);

X = zeros(m,n);

% build n points which are lying in n-1 dimensions.
% the first is zero (0,0,...,0)
A0 = dist2xyz(D(1:n,1:n),n-1) % (n)x(n-1)


% fill first n points. The last coordinate is zero
X(1:n,1:n-1) = A0

% whant to build n+1 ... m  points.
% the distance from first n points to to n+j point is given by D(1:n,n+j)
%
% Let new point be x,  distances to the given points(a1...an) be r1,...,rn
% then
% .. 
%   (x-ai)'(x-ai) = x'x - 2ai'x + ai'ai = ri^2 
% ..
%  the first point a1=0 --> x'x = r1^2
%
%  For all other (n-1) eqs:
%  -2ai'x = ri^2 - r1^2 - ai'ai == bi
%  
%  This is a system of linear eqs whith matrix  -2[a2;...;an]  
%  we have only n-1 eqs but n unknowns (coordinates of x)
%  So, we can solve it wrt first n-1 columns, 
%  and the last coordinate get from normalization :  x'x=r1^2 --> 
%  xn = +-sqrt( r1^2 - x(1:n-1)'x(1:n-1) )
A = A0(2:n,1:n-1)

for k = n+1:m
  % -2*Ax = ri^2 - r1^2 - ai'ai
  r1 = D(1,k);
  b = D(2:n,k).^2 - r1^2 - diag(A*A');
  % -2Ax = b --> -0.5*A^-1*b
  x = -0.5*A^-1*b
  xn = sqrt( r1^2 - x'*x)
  X(k,:) = [ x' xn ];
end
 

  













