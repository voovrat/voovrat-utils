function R = mycellfun2(fn,Cell,check_nan)

if nargin<3
   check_nan = 1;
end


N=length(Cell);
R=cell(N,1);

for i=1:N

if check_nan 

   if iscell(Cell{i,1}) || isstruct(Cell{i,1}) || ~isnan(Cell{i,1}) 
        R{i} = fn(Cell(i,:));
    else
        R{i}  = NaN;
    end

else

    R{i} = fn(Cell(i,:));

end

end
