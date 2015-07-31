function B=symmatrix_adj(A)
%
%  B= symmatrix_adj(A)
%  
%  adj(A) = det(A) * A^-1
%
%  adj(A)_ij = (-1)^{i+j}*det(Minor_ji)
% 

[M,N] = size(A);

if M~=N 
   error('matrix should be square!')
end 

B = cell(N,N);

for i =1:N
   for j=1:N

       I = setdiff((1:N),i);
       J = setdiff((1:N),j);
       Minor = A(J,I);
       s = num2str( (-1)^(i+j) );
       B{i,j} = sym_mul( s, symmatrix_det(Minor) );

   end
end

