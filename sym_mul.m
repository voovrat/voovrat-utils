function [c,summands_c,koefs_c] = sym_mul(a,b)
%
%   c = sym_mul(a,b,tol)
%
%   symbolic product of a and b
% 
%   a,b,c are strings
%
%   if symmands contain the sum the product will contain 
%   a sum of product of the terms
%
%  !!!!!! no brackets allowed !!!!!!
%


[ summands_a, koefs_a ] = sym_parse_string(a);
[ summands_b, koefs_b ] = sym_parse_string(b);

M = length(summands_a);
N = length(summands_b);

summands_c = cell(M*N,1);
koefs_c = ones(M*N,1);

for i = 1:M
for j = 1:N

     summands_c{(i-1)*N + j} =  [ summands_a{i} ; summands_b{j} ];
     koefs_c((i-1)*N + j) = koefs_a(i) * koefs_b(j);
end
end


c = sym_to_string(summands_c,koefs_c);
