function [WX,WY,WZ] = vprodn(VX,VY,VZ,UX,UY,UZ)
% vector product (do not know how is called the original function )
% 

%   1  2  3  
% u x  y  z 
% v x  y  z 
% 

WX = UY.*VZ - UZ.*VY;
WY = - UX.*VZ  + UZ.*VX;
WZ = UX.*VY - UY.*VX;