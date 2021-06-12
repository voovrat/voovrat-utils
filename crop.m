function crop(image_file,output_file)

A=myimread(image_file);

B = double(A(:,:,1)) + double(A(:,:,2)) + double(A(:,:,3));
B(A(:,:,4) == 0) = 3;

maxcol = 3-0.001;

[m,n]=size(B);

H = sum(B);

for l=2:n
   if H(l)<m*maxcol
      break
   end
end

l=l-1;


for r=n-1:-1:1
   if H(r)<m*maxcol
      break
   end
end
r=r+1;

V = sum(B');

for t=2:m
   if V(t)<n*maxcol
      break
   end
end
t=t-1;


for b=m-1:-1:1
   if V(b)<n*maxcol
      break
   end
end
b=b+1;

A1 = A(t:b,l:r,:);
imwrite(A1(:,:,1:3),output_file,'Alpha',A1(:,:,4));




