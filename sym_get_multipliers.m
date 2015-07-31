function [names,koef]=sym_get_multipliers(s)
%
%  return the list of multipliers
%
%  !!!! NOTE : no + - signs allowed !!!!!
%
%  names - cell array with names
%  signs - array with signs


s_amp0 = strrep(s,'*','@');
s_amp = strrep(s_amp0,'/','@1/');

muls = strread(s_amp,'%s','delimiter','@');

N = length(muls);

koef = 1;
%names = cell(N,1);
names = {};

for i=1:N

    mul0 = muls{i};

    mul1 = strrep(mul0,'(',' ');
    mul = strrep(mul1,')',' ');

    div = strread(mul,'%s','delimiter','/');

    K = str2num(div{end});

    if ~isempty(K)

         if length(div)==1
              koef *= K;
         else 
              koef /= K;
         end % div

    else

         names = [ names; { strtrim(mul) } ];

    end

end
