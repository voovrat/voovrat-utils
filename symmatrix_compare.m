function [EQ,NEQ] = symmatrix_compare(A,B)
%
%    eq = symmatrix_compare(A,B)
% 


EQ = false;

[M,N]= size(A);
[M1,N1] = size(B);

if M~=M1 || N~=N1
   return
end

EQ = true;
NEQ = 0;

for i=1:M
for j=1:N

   EQ1 = sym_compare(A{i,j},B{i,j});

   if EQ1
      NEQ = NEQ + 1;
   else
      EQ = false;
   end

end
end


