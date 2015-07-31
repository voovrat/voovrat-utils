function cube2file(CUB,x0,y0,z0,dx,dy,dz,fname,NXYZ)
%  
%   Volodymyr P Sergiievskyi, Max Planck Institute for Mathematics in the Sciences
%    cube2file(CUB,x0,y0,z0,dx,dy,dz,fname,NXYZ)
%
%  Save 3D data array to the Gaussian Cube file
%  
%  INPUT PARAMETERS:
%
%   CUB - 3D matlab array with data values
%   x0,y0,z0 - coordiantes of the corner of the cube
%   dx,dy,dz - grid steps in each direction
%   fname    - name of the output file 
%   NXYZ     - coordinates of the atoms
%     first column - atom number in periodic table
%     last three - atom coordinates
      

if nargin<12
    NXYZ = [];
end


f = fopen(fname,'w');

fprintf(f,'Cube\n');
fprintf(f,'OUTER LOOP: X, MIDDLE LOOP: Y, INNER LOOP: Z\n');
L = size(NXYZ,1);
fprintf(f,'%5.0f%12.6f%12.6f%12.6f\n',L,x0,y0,z0);
[M,N,K]=size(CUB);

fprintf(f,'%5.0f%12.6f%12.6f%12.6f\n',M,dx,0,0);
fprintf(f,'%5.0f%12.6f%12.6f%12.6f\n',N,0,dy,0);
fprintf(f,'%5.0f%12.6f%12.6f%12.6f\n',K,0,0,dz);

for i=1:L
    fprintf(f,'%5.0f%12.6f%12.6f%12.6f%12.6f\n',NXYZ(i,1),0,NXYZ(i,2),NXYZ(i,3),NXYZ(i,4));
end


CL = CUB(:);

LL=length(CL);

L6 = (ceil((LL+1)/6)-1)*6;

CL6 = reshape(CL(1:L6),L6/6,6);

fmt = '%12.6f';
fmt3 = [ fmt fmt fmt];
fmt6 = [ fmt3 fmt3 '\n' ];

fprintf(f,fmt6,CL6);

fprintf(f,'%12.6f',CL(L6+1:end));
if L6~=LL
    fprintf(f,'\n');
end

fclose(f);
