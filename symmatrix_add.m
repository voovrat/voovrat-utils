function C = symmatrix_add(A,B)
%
%  C = symmatrix_mul(A,B)
%
%  A and B are cell matrics with string in them
%
%  C is a cell matrix with product
% 


[M,N] = size(A);
[M1,N1] = size(B);

if (N ~= N1) || (M~=M1)
   s = sprintf('Incompartible size: %g x %g  vs %g x %g',M,N,M1,N1);
   error(s)
end

C = cell(M,N);

for i=1:M
for j=1:N

    C{i,j} = sym_add(A{i,j},B{i,j});

end
end
