function b = sym_simplify(a)
%
%  b = sym_simplify(a)
% 
%  removes the repeating terms from a
%

if ~iscell(a)
   a = {a};
end

[m,n] = size(a);

for ii=1:m
for jj=1:n


[summands_a,koefs_a] = sym_parse_string(a{ii,jj});

N = length(summands_a);

for i=1:N

if koefs_a(i) == 0
   continue
end


   for j=i+1:N

         if koefs_a(j) == 0
              continue
         end

         if length(summands_a{i}) ~= length(summands_a{j})
             continue
         end
 
         A = sort(summands_a{i}); 
         B = sort(summands_a{j});

         if sum(strcmp(A,B)) == length(A)

               koefs_a(i) = koefs_a(i) + koefs_a(j);
               koefs_a(j) = 0;

         end

   end

end

b{ii,jj} = sym_to_string(summands_a,koefs_a);

end  % jj
end  % ii

if ii*jj == 1
  b = b{1,1};
end


