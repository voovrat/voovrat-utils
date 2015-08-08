function B = myimread(file)
%
%  output in RGBA with doubles [0..1]
%

[A0,map,alpha0] = imread(file);

A1 = double(A0);

Mx = max(max(max(A1)));

if Mx<2
   A = A1;
   alpha = double(alpha0);
else
   A = A1/255;
   alpha = double(alpha0)/255;
end

[m,n,k] = size(A);

B = zeros(m,n,4);
if k==3
   B(:,:,1:3) = A;
else
   B(:,:,1) = A;
   B(:,:,2) = A;
   B(:,:,3) = A;
end

B(:,:,4) = alpha;
