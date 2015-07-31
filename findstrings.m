function L = findstrings(strings,pattern)
%
% findstrings(strings,pattern)
%
% strings - cell array
% return indeces at which the pattern is substring of the string
%

N=length(strings);

L=[];

for i = 1:N

    if ~isempty( findstr(strings{i},pattern) )
        L = [L;i];
    end

end
