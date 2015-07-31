function c=sym_sum(a,b)
%
%   c = sym_sum(a,b)
%
%   symbolic sum of a and b
% 
%   a,b,c are strings
%
%  !!!!!! no brackets allowed !!!!!!

[summands_a,koefs_a] = sym_parse_string(a);
[summands_b,koefs_b] = sym_parse_string(b);

summands_c = [summands_a ; summands_b ];
koefs_c = [ koefs_a; koefs_b];

c = sym_to_string(summands_c,koefs_c);

