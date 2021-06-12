function B = block_mean2(A,nx,ny )

[m,n] = size(A);

sx = n / nx;
sy = m / ny;

B = zeros(ny,nx);

for i=1:ny
for j=1:nx

  xfirst = round((j-1)*sx )+1;
  xlast = round(j*sx);
  
  yfirst = round((i-1)*sy)+1;
  ylast  = round(i*sy);
  
  B(i,j) = mean(mean(A(yfirst:ylast,xfirst:xlast )));

end
end