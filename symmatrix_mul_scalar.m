function B = symmatrix_mul_scalar(A,scal)
%
%  B = symmatrix_mul_scalar(A,scal)
%
%  A is the cell matrics with string in them
%  scal is scalar ( symbolic )
%  B is a cell matrix with product
% 


[M,N] = size(A);

B = cell(M,N);

for i=1:M
for j=1:N

    B{i,j} = sym_mul(A{i,j},scal);

end
end
