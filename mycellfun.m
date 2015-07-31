function R = mycellfun(fn,Cell,check_nan)

if nargin<3
   check_nan = 1;
end


N=length(Cell);
R=cell(N,1);

for i=1:N

if check_nan 

   if iscell(Cell{i}) || isstruct(Cell{i}) || ~isnan(Cell{i}) 
        R{i} = fn(Cell{i});
    else
        R{i}  = NaN;
    end

else

    R{i} = fn(Cell{i});

end

end
