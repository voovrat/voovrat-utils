function y=gaussian(x,a,sigma)

y = 1/sqrt(2*pi)/sigma * exp( -0.5*(x-a).^2/sigma^2);
