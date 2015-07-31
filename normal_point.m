function [x,y]=normal_point(x0,y0,x1,y1,L)
%[x,y]=normal_point(x0,y0,x1,y1,L)
% return the normal vector. L is the length (default 1)
%

if nargin<5
    L=1;
end

A0 = x1-x0;
B0 = y1-y0;

DX0 = L / sqrt(1+(A0/B0)^2);

if B0
  DY0 = - A0/B0*DX0;
else
  DY0 = 1;
end

S=sign(det([A0 B0; DX0 DY0]));

x = x0+S*DX0;
y = y0+S*DY0;

