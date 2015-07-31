function write_xyz(atoms,A,fname)

nlin = size(A,1);

f=fopen(fname,'w');
fprintf(f,"%0.0f\n%s\n",size(A,1),fname);

for i=1:nlin

  fprintf(f,"%s %0.10f %0.10f %0.10f\n",atoms{i},A(i,1),A(i,2),A(i,3));
end

fclose(f);
