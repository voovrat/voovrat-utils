function B = myimread(file)
%
%  output in RGBA with doubles [0..1]
%

[A0,map,alpha0] = imread(file);

A1 = double(A0);

Mx = max(max(max(A1)));

if Mx<2
   F = 1;
else
   F = 255;
end

A = A1/F;

if sum(size(alpha0))==0
   alpha = ones(size(A0,1),size(A0,2));
else
   alpha = double(alpha0)/F;
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
