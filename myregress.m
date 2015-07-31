function a = myregress(Y,X)
%
%  a = regress(Y,X)
%
%  linear regression (Patch for octave)
%
%  Y ~ X*a
%  (Y-Xa)'*(Y-Xa) -> min
%   Y'Y - 2a'X'Y + a'X'Xa -> min
%  d/da = -2X'Y + 2X'Xa = 0
%     a = (X'X)^-1 * X'Y
%

I = isfinite( sum(X,2) + sum(Y,2) );

X = X(I,:);
Y = Y(I,:);

a = (X'*X)^-1*X'*Y;
