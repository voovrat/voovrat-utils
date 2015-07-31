function cell2csv(C,csv_fname)
%
% Volodymyr P Sergiievskyi, Max Planck Institute for Mathematics in the Sciences
%
% cell2csv(C,csv_fname)
% 
%  Write the cell matrix C to the the coma separated values file csv_fname
%


f=fopen(csv_fname,'w');

[m,n] = size(C);

for i=1:m
    
    for j=1:n
      fprintf(f,'%s',mat2str(C{i,j}));
      if j<n
          fprintf(f,',');
      end
    end
    fprintf(f,'\n');
end


fclose(f);
