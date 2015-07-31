function inReg = getRegion3d(g3d,inReg,fn,R)
%
%  getRegion3d(g3d,initReg,fn)
%
%  get all neighboring points (neighbours of neighbours, etc)
%  for which fn(A,B) is true,
%  where A is the point inside the (growing) region, B is its neighbour (outside the growing region)
%
% vic defines how many neigbours are counted
 
[sy,sx,sz] = size(g3d);

icurrent = 0;
itotal = 0;

idx_list = zeros(0,3);

for i=1:sy
for j=1:sx
for k=1:sz

   if inReg(i,j,k)
      idx_list = [ idx_list ; i j k ];
      itotal = itotal + 1;
   end

end
end
end

icurrent = 1

while icurrent < itotal

  %[icurrent itotal]

   i = idx_list(icurrent,1);
   j = idx_list(icurrent,2);
   k = idx_list(icurrent,3);

   fR = floor(R);


   for dx = -fR:fR
   for dy = -fR:fR
   for dz = -fR:fR


      if sqrt(dx^2 + dy^2 + dz^2 ) < R &&...
         check_size3(i+dx,j+dy,k+dz,sy,sx,sz) 
   
%         inReg(i+dy,j+dx,k+dz)

         if ~inReg(i+dy,j+dx,k+dz) 

          %  fn( g3d(i,j,k), g3d(i+dy, j+dx, k+dz) )

            if fn(g3d(i,j,k), g3d(i+dy,j+dx,k+dz) )


               idx_list = [idx_list; i+dy, j+dx, k+dz ];
               itotal = itotal + 1;

               inReg(i+dy,j+dx,k+dz) = 1;
               [i+dy j+dx k+dz  icurrent itotal]

            end
         end

      end % if
      

      


   end % i
   end % j
   end % k


   icurrent = icurrent + 1;

end  % while


