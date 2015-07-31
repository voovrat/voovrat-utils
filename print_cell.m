function print_cell(C,file,delim,EOL)



if nargin<2
   f = stdout;
else
  f = fopen(file,'w');

end

if nargin<3
    delim=' ';
end

if nargin<4
    EOL='';
end

[M,N]=size(C);

for i=1:M
    for j=1:N

        V=C{i,j};

        if ischar(V)
            if j==1
                fprintf(f,'%20s',V);
            else
                fprintf(f,'%10s',V);
            end
        else

           if abs(round(V) - V)<1e-14
              fprintf(f,'%10.0f',V);
           else
            fprintf(f,'%10.3f',V);
           end
        end

        if j<N
            fprintf(f,'%s',delim);
        end

    end
    fprintf(f,'%s\n',EOL);
end

if nargin>=2
    fclose(f);
end
