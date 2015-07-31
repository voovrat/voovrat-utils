function save_ball_xyz(XX,YY,ZZ,filename)


f = fopen(filename,'w');
fprintf(f,'%0.0f\n',length(XX));
fprintf(f,'the Ball\n');

for i=1:length(XX)

  fprintf(f,'C %0.3f %0.3f %0.3f\n',XX(i),YY(i),ZZ(i));

end

fclose(f);

