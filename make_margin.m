function make_margin(file,maxsize,margin,output)

crop(file,'tmp.png');

A = myimread('tmp.png');

[m,n,k]=size(A);

mx=max(m,n);

dpi=mx/str2num(maxsize);

px_margin = str2num(margin)*dpi;
s = floor(px_margin);

B = [ zeros(s,n + 2*s,k);  zeros(m,s,k) A zeros(m,s,k); zeros(s,n+2*s,k)];

imwrite(B(:,:,1:3),output,'Alpha',B(:,:,4));



