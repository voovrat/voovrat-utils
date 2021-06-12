function w = vprod(v,u)
% vector product (do not know how is called the original function )
% 

%   1  2  3  
% u x  y  z 
% v x  y  z 
% 
w = zeros(3,1);

w(1) = u(2)*v(3) - u(3)*v(2);
w(2) = - u(1)*v(3) + u(3)*v(1);
w(3) = u(1)*v(2) - u(2) * v(1);
