function y=nan_boundaries(x,a,b)

if (x<a) || (x>b)
   y = NaN;
else
   y = x;
end
