function plot_distr(prefix,output)
%
%  plot_distr(prefix,output)
%
%  converts 3d distribution to tricolor file (which can be then used as input for illuinate)  


if nargin<1
  prefix='mol_in_water_';
end

if nargin<2
  output = 'dens.tricolor'
end

gx=load([ prefix 'X.grd' ]);
gy=load([ prefix 'Y.grd' ]);
gz=load([ prefix 'Z.grd' ]);

g0=load([ prefix 'g0.3d' ]);

[g3,GX,GY,GZ]=prepareToSlice(g0,gx,gy,gz,{'z','y','x'});

mx = length(GX)/2;
my = length(GY)/2;
mz = length(GZ)/2;

[DU,EU]=unit_names;

K = unit2unit(DU,'Bohr','Angstr');

dx = (GX(2)-GX(1) ) * K;
dy = (GY(2) - GY(1) )*K;

f=fopen(output,'w');

z0 = GZ(mz) + 10;

for i=1:2*my
fprintf('%0.0f of %0.0f\n',i,2*my);
for j=1:2*mx

   y0 = GY(i) * K - dy/2;
   x0 = GX(j) * K - dx/2;

   y1 = GY(i) * K + dy/2;
   x1 = GX(j) * K + dx/2;
   
 
   val = g3(i,j,mz);

   if val<1
      
      r = 0;
      g = 0;
      b = val;

   elseif val<2
      
      r=0 ;
      g = (val-1);
      b = 1;

   elseif val<3

      r = val-2;
      g = 1;
      b = 1;

   elseif val<4

      r=1;
      g=1;
      b = 4 - val;

   elseif val<5

      r = 1;
      g = 5-val;
      b = 0;

   else
      r = 1;
      g = 0;
      b = 0;
   end

   col = [ 0 val val ];

   

   fprintf(f,'%f %f %f  %f %f %f %f %f %f %f %f %f\n',x0,y0,z0, x0,y1,z0, x1,y1,z0,r,g,b);

   fprintf(f,'%f %f %f  %f %f %f %f %f %f %f %f %f\n',x0,y0,z0,x1, y0,z0,x1,y1,z0,r,g,b);

end
end

fclose(f);
