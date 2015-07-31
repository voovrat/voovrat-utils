function [a,x,y,D1]=regress_image(fname,xlims,ylims)

im=imread(fname);
A=double(im<128);


[M,N]=size(A);

xsiz = xlims(2)-xlims(1);
x0 = xlims(1);

ysiz = ylims(2) - ylims(1);
y0 = ylims(1);


X=ones(M,1)*(0:N-1) * xsiz / N + x0;
Y=(M-1:-1:0)'*ones(1,N) * ysiz / M + y0;

x=X(A>0)(:);
y=Y(A>0)(:);

D = [ x ones(size(x)) ];

a=myregress(y,D);


D1 = [xlims' [1;1] ];


%plot(x,y,'s',x1,D1*a,'k')
