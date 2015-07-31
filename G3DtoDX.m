function G3DtoDX(GX,GY,GZ,g3D,dxFileName)
%
% V. Sergiievskyi, MPI MIS 2011
% 
%  G3DtoDX(GX,GY,GZ,g3D,dxFileName)
%
% Saves 3D distribution to *.dx format
%
%  GX,GY,GZ  - grids in x,y,z, directions
%  g3D - 3D distribution
%  dxFileName - name of the *.dx file
%
%

f=fopen(dxFileName,'w');

Nx=length(GX);
Ny=length(GY);
Nz=length(GZ);

fprintf(f,'object 1 class gridpositions counts%8.0f%8.0f%8.0f\n',Nx,Ny,Nz);
fprintf(f,'origin%16g%16g%16g\n',GX(1),GY(1),GZ(1));
fprintf(f,'delta%16g 0 0\n',GX(2)-GX(1));
fprintf(f,'delta 0 %16g 0\n',GY(2)-GY(1));
fprintf(f,'delta 0 0 %16g\n',GZ(2)-GZ(1));
fprintf(f,'object 2 class gridconnections counts%8.0f%8.0f%8.0f\n',Nx,Ny,Nz);
fprintf(f,'object 3 class array type double rank 0 items%8.0f follows\n',Nx*Ny*Nz);

col=1;
for j=1:Nx

    fprintf('%6.2f%%\n',j/Nx*100);
    for i=1:Ny
        for k=1:Nz
   
        fprintf(f,'%16E',g3D(i,j,k));
        col=col+1;
        if col>3
            fprintf(f,'\n');
            col=1;
        end
            
        end
    end
end

fprintf(f,'object "Untitled" call field\n');
fclose(f);
