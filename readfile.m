function C = readfile(fname)

f=fopen(fname,'r');

C=[];

while ~feof(f)
    s = fgets(f);
    C=[C ;{strtrim(s)}];
        
end

fclose(f);