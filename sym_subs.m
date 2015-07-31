function b = sym_subs(a,names,vals)
%
%   b = sym_subs(a,name,val)
% 
%   Subtitutes name in a to val
%

if ~iscell(names)
   names = { names};
   vals = { vals};
end

if ~iscell(a)
   a = {a};
end


Nsubs = length(names);



[m,n]=size(a);





for ii=1:m
for jj=1:n

[summands,koefs] = sym_parse_string(a{ii,jj});
N = length(summands);
for i=1:N

    muls = summands{i};
    M = length(muls);
    for j=1:M

       for k=1:Nsubs

          if strcmp(muls{j},names{k})

              V = str2num(vals{k});
              if isempty(V)
                  muls{j} = vals{k};
              else
                  muls{j} = '1';
                  koefs(i) = koefs(i) * V;
              end
          end
       end % k
    end% j
    
    summands{i} = muls;

end %i

b{ii,jj} = sym_simplify(sym_to_string(summands,koefs));

end % jj
end % ii

if ii*jj == 1
    b = b{1,1};
end
