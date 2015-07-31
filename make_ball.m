function [XX,YY,ZZ]=make_ball(R,N)


if nargin<2
 N = 9;
end

%N = 9;
%R = 8;

N2 = (N-1)/2;

X = [];
Y = [];
Z = [];

for i=-N2:N2
   for j=-N2:N2

      % coordinates of the point on cube:   (i,j,N/2) 
      rc = sqrt( i^2 + j^2 + (N/2)^2 ); 
      % project the point to the sphere
      x = i*R/rc;
      y = j*R/rc;
      z = N/2 * R/rc;

      X = [X;x];  
      Y = [Y;y];
      Z = [Z;z];

   end
end

Xup = X;
Yup = Y;
Zup = Z;

Xdown = X;
Ydown = Y;
Zdown = -Z;

Xright = Z;
Yright = X;
Zright = Y;

Xleft = -Z;
Yleft = X;
Zleft = Y;


Xfwd = X;
Yfwd = Z;
Zfwd = Y;

Xbkwd = X;
Ybkwd = -Z;
Zbkwd = Y;

XX = [ Xup ;Xdown; Xleft; Xright; Xfwd; Xbkwd];
YY = [ Yup ;Ydown; Yleft; Yright; Yfwd; Ybkwd];
ZZ = [ Zup ;Zdown; Zleft; Zright; Zfwd; Zbkwd];

%plot3(XX,YY,ZZ,'s');






