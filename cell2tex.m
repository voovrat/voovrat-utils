function cell2tex(C,texFile,noheader)

if nargin<3
   noheader=false;
end

[m,n]=size(C);

f=fopen(texFile,'w');

if ~noheader

   fprintf(f,'\\documentclass[10pt]{article}\n');
   fprintf(f,'\\usepackage[top=0.5cm, bottom=0.5cm, left=0.5cm, right=0.5cm]{geometry}\n');

   fprintf(f,'\\begin{document}\n');
end

fprintf(f,'\\begin{tabular}{');

for i=1:n
    fprintf(f,' l ');
end

fprintf(f,'}\n');

for i=1:m
    for j=1:n

        if isnumeric(C{i,j})
            ss = num2str(C{i,j},'%0.3f');
        else
            ss = num2str(C{i,j});
        end
        
        
        fprintf(f,'%s',addSlash(ss));
        
        if j<n
           fprintf(f,'&    '); 
        else
          fprintf(f,'\\\\\n'); 
        end
    end
end

fprintf(f,'\\end{tabular}\n');

if ~noheader
   fprintf(f,'\\end{document}\n');
end

fclose(f);

function s1 = addSlash(s)

s1 = [];

escchr = '_^&%\';

for i=1:length(s)
    
    if ismember(s(i),escchr)
        s1=[s1 '\' ];
    end
    
    s1=[s1 s(i) ];
end
