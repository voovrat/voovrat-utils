function s = setfields(s,fldcell)
%
% 
%  s = setfields(structure_name, fldcell)
% where fldcell = {'K1', v1, 'K2', v2, ... }
%

N=length(fldcell)

for i=1:2:N

    s=setfield(s,fldcell{i},fldcell{i+1});

end
