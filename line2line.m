function P = line2line(X0,Y0,X1,Y1,k)
%
%  X0 = [x00, x01], Y0= [y00 , y01]; X1 = [x10, x11]; Y1= [y10, y11];
%  return the 2D transformation, which moves line X0,Y0 to the line X1 Y1,
%   change the scale in the nomral direction by k times...
%  PA=B
%

if nargin<5
    k=1;
end

[NX0,NY0]=normal_point(X0(1),Y0(1),X0(2),Y0(2),1);
[NX1,NY1]=normal_point(X1(1),Y1(1),X1(2),Y1(2),k);

A = [X0 NX0; Y0 NY0; 1 1 1];
B = [X1 NX1; Y1 NY1; 1 1 1];

P = B*A^-1;