function s = sym_to_string(summands,koefs,tol)
%
%  s = sym_to_string(summands,koefs)
%
%  Convert the symbolic su of products to string
%  summands - cell array of cell arrays representing the sum of products
%  koefs - koefficients of summands
%
%  IF tol is given, koefficients are represented as rational fractions
% 

if nargin<3
  tol = 0;
end

N = length(summands);

s = '';

for i=1:N

   if abs(koefs(i)) < 1e-8

     continue
   end

   sign = '';
   if i>1 && koefs(i) >=0 
       sign = ' + ';
   end

   if koefs(i)<0
       sign = ' - ';
   end

    s = [s sign];

   M = length(summands{i});

   if M>0

     if abs(abs(koefs(i))-1)>1e-8
            s = [ s xnum2str(abs(koefs(i)),tol) '*' ];
      end

   else
    
        s = [ s xnum2str(abs(koefs(i)),tol) ];
   end


   muls = sort(summands{i});

   for j=1:M
       if j>1
          s = [ s '*' ];
       end

       s = [ s  muls{j} ];
   end

end


if isempty(s)
   s= '0';
end


function s= xnum2str(x,tol)

if tol==0
    s = num2str(x,'%g');
else
    [N,D]=rat(x,tol);
    s = [ num2str(N) '/' num2str(D) ];
end


