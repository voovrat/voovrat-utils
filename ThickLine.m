function h=ThickLine(X0,X1,Y0,Y1,Z0,Z1,C,D)

if nargin<8
    D=1;
end

N=length(X0);

h=[];

for i=1:D:N-1
    h0=patch([X0(i) X0(i+1) X1(i)],[Y0(i) Y0(i+1) Y1(i)],[Z0(i) Z0(i+1) Z1(i)],C);
    h1=patch([X1(i) X1(i+1) X0(i+1)],[Y1(i) Y1(i+1) Y0(i+1)],[Z1(i) Z1(i+1) Z0(i+1)],C);
    h=[h;h0;h1];
end

set(h,'LineStyle','none');
set(h,'FaceLighting','none');