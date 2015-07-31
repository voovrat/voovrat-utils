function strV=fine_num(V)
%
% Volodymyr P Sergiievskyi, Max Planck Institute for Mathematics in the Sciences
%
% Convert the number to the tex-comatible string format with 10^ notation 
%
% Usage:  strV=fine_num(V)




ord = round(log(V)/log(10));


Z = V/10^ord;
strZ = num2str(Z,2);

strV = [  strZ '\cdot 10^{' num2str(ord) '}' ];

