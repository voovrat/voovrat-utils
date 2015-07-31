function [summands,koefs]=sym_parse_string(s)
%
%  [summands,koefs]=sym_parse_string(s)
%  
%  assume that the string is sum of products
%  !!! BRACKETS ARE NOT ALLOWED !!!
% 
%  summands : cell array of cell arrays which represent products
%  koefs : koefficient of summands

[names,signs]=sym_get_summands(s);

N = length(names);

summands = cell(N,1);
koefs = ones(N,1);

for i=1:N

    [muls,K] = sym_get_multipliers(names{i});

    summands{i} = muls;
    koefs(i) = signs(i) * K;

end


