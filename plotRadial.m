function [S,X,Y,xgr,ygr] = plotRadial(f,dR,x0,y0,x1,y1,x,y,dx,dy)
%
% x0:dx:x1, y0:dx:y1 - grid
% 
%
xsiz = x1-x0;
ysiz = y1-y0;

M = ceil(ysiz/dy);
N = ceil(xsiz/dx);
K = length(f);

xgr = (x0+dx:dx:x0+xsiz);
ygr = (y0+dy:dy:y0+ysiz);

X = ones(M,1)*(xgr-x);
Y = (ygr-y)'*ones(1,N);

L = ceil(sqrt((xsiz/dx)^2+(ysiz/dy)^2));

if K<L/dR
    g=zeros(L,1);
    g(1:K)=f(:);
else
    g=f;
end

R = sqrt(X.^2+Y.^2);
%Th = atan2(Y,X);

S=zeros(M,N);

I = ceil(R(:)./dR);
I(I==0) = 1;
I(I>M*N) = 1;

S( : ) = g(I);
%G = g*(1:L+1);

%S = G(R,Th);



