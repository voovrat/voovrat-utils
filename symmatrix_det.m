function D = symmatrix_det(A)

[M,N] = size(A);

if M~=N
   error('matrix should be square!!')
end 

if M==1
  D = A{1,1};
  return
end

D = '0';

for i=1:N
    
    I = setdiff((1:N),i);
    Minor = A(2:M,I);
    if mod(i,2) == 1
        D = sym_add( D, sym_mul(A{1,i},symmatrix_det(Minor)) );
    else
        D = sym_sub( D, sym_mul(A{1,i},symmatrix_det(Minor)) );
    end 

end

D = sym_simplify(D);
