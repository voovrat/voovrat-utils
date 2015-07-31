function [names,signs]=sym_get_summands(s)
%
%  return the list of summands
%  names - cell array with names
%  signs - array with signs


s_amp0 = strrep(s,'+','@+');
s_amp = strrep(s_amp0,'-','@-');

summands = strread(s_amp,'%s','delimiter','@');

if isempty(strtrim(summands{1}))
   summands = summands(2:end);
end

N = length(summands);

signs = ones(N,1);
names = cell(N,1);

for i=1:N

    summand = summands{i};

    if summand(1) == '-'
        signs(i) = -1;
    end

    if summand(1) == '-' || summand(1) == '+'
        summand(1) = ' ';
    end

    names{i} = strtrim(summand);

end
