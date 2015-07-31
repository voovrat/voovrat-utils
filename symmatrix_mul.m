function C = symmatrix_mul(A,B)
%
%  C = symmatrix_mul(A,B)
%
%  A and B are cell matrics with string in them
%
%  C is a cell matrix with product
% 


[M,N] = size(A);
[N1,K] = size(B);

if N ~= N1
   s = sprintf('Incompartible size: %g x %g  vs %g x %g',M,N,N1,K);
   error(s)
end

C = cell(M,K);

for i=1:M
for j=1:K

    c_ij = '0';

    for k = 1:N

        mul = sym_simplify( sym_mul(A{i,k},B{k,j}) );
        c_ij = sym_simplify ( sym_sum(c_ij,mul) );

    end

    C{i,j} = c_ij;

end
end
