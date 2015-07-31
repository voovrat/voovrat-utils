function [S,X,Y,Z,xgr,ygr,zgr] = plotSpherical(f,dR,x0,y0,z0,x1,y1,z1,x,y,z,dx,dy,dz)
%
%  stupd Y Z X !!!! remember it!!! (because of Gauss cube... )
%


xsiz = x1-x0;
ysiz = y1-y0;
zsiz = z1-z0;

%M = ceil(xsiz/dy);
%N = ceil(ysiz/dx);
%K = ceil(zsiz/dz);
%L = length(f);

xgr = (x0+dx:dx:x0+xsiz);
ygr = (y0+dy:dy:y0+ysiz);
zgr = (z0+dz:dz:z0+zsiz);


M = length(zgr);
N = length(ygr);
K = length(xgr);
L = length(f);

%X = ones(M,1)*(xgr-x);
%Y = (ygr-y)'*ones(1,N);

[Y,Z,X]= meshgrid(ygr-y,zgr-z,xgr-x);

LL = ceil(sqrt((xsiz/dx)^2+(ysiz/dy)^2+(zsiz/dz)^2));

if L<LL/dR
    g=zeros(LL,1);
    g(1:L)=f(:);
else
    g=f;
end

R = sqrt(X.^2+Y.^2+Z.^2);
%Th = atan2(Y,X);

S=zeros(M,N,K);

I = ceil(R(:)./dR);
I(I==0) = 1;
I(I>M*N) = 1;

S( : ) = g(I);
%G = g*(1:L+1);

%S = G(R,Th);


