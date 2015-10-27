function D = mydist_fast(X)
%
%  D(i,j) = sqrt((x(i,:) - x(j,:))^2)
%
%
%
%  (xi - xj)^2 = xi^2 - 2xixj + xj2
%
%

m = size(X,1);

XiXj = X * X';

X2 = sum(X.^2,2);

Xi2 = X2 * ones(1,m);
Xj2 = ones(m,1) * X2';

D = sqrt( Xi2 - 2*XiXj + Xj2 );

