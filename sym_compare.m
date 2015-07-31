function EQ = sym_compare(a,b)
%
% EQ = sym_compare(a,b)
% 

EQ = false;

aa = sym_simplify(a);
bb = sym_simplify(b);

[summands_a,koefs_a] = sym_parse_string(aa);
[summands_b,koefs_b] = sym_parse_string(bb);

Na = length(summands_a);
Nb = length(summands_b);

if Na ~= Nb
   return
end 

N=Na;

% strings which contain string representations of multipliers
str_sums_a = cell(N,1);
str_sums_b = cell(N,1);

for i=1:N

     str_sums_a{i} = get_muls_repr(summands_a{i},koefs_a(i));
     str_sums_b{i} = get_muls_repr(summands_b{i},koefs_b(i));

end

Cmp = strcmp( sort(str_sums_a), sort(str_sums_b) );

EQ = (sum(Cmp) == N);

endfunction

function str_a = get_muls_repr(muls,koef)

    muls_a = sort(muls);
    
    str_a = num2str(koef,'%g');
    for j=1:length(muls_a)
            str_a = [ str_a '*' ];
            str_a = [ str_a  muls_a{j} ];
    end
endfunction
