function A1 = cropX(B,border,delta)

if nargin<2
  border = 0;
end

if nargin<3
  delta = 0.001;
end

B = (1-B);

maxcol = 1-delta;

[m,n]=size(B);

H = sum(B);

for l=2:n
   if H(l)<m*maxcol
      break
   end
end

%l=l-1;


for r=n-1:-1:1
   if H(r)<m*maxcol
      break
   end
end
%r=r+1;

V = sum(B');

for t=2:m
   if V(t)<n*maxcol
      break
   end
end
%t=t-1;


for b=m-1:-1:1
   if V(b)<n*maxcol
      break
   end
end
%b=b+1;


R = border;
Z = zeros(R,R);
ZV = zeros(b-t+1,R);
ZH = zeros(R,r-l+1);

A1 = 1-B(t:b,l:r);
A1 = [ Z ZH Z; ZV 1-B(t:b,l:r) ZV; Z ZH Z];


