function [S3D,GX,GY,GZ,X,Y,Z]=prepareToSlice(S,gridX,gridY,gridZ,DimOrder)
%
%   [S3D,GX,GY,GZ,X,Y,Z]=prepareToSlice(S,gridX,gridY,gridZ,DimOrder)
%
%   Function takes the distribution in the one-column format and convert it to the format, 
%   understandable by the slice function.
%   (see also fullSlice2)
%
%  INPUT PARAMETERS
%    S     - distribution in the one-column format
%   gridX,gridY,gridZ - 1-d arrays: grids point in the X,Y,Z directions. 
%                       grids should be uniform, but the grid points should
%                       not necessarily go int the growwing direction.
%   DimOrder - cell array, which determine the order of data in the
%              distribution column. Should contain 3 letters: 'x', y' and
%              'z' in certain order. The first letter indicate the fastest
%               -changing dimension, second - the middle changing and the
%               last - the slowest. By default DimOrder = {'z','y','x'};
%
%  OUPUT PARAMETERS
%
%   S3D - 3D distribution in the slice-understandable format
%   GX,GY,GZ - grid vectors reordered in a proper way for slice
%   X, Y, Z  - grid points, created by the function meshgrid 
%



if nargin<5
    DimOrder=  {'z','y','x'}; %  from small to big
                              % the first one changes the fastest
end

Nx = length(gridX);
Ny = length(gridY);
Nz = length(gridZ);

Dims=zeros(1,3);
Grids = cell(1,3);

[a,ix]=ismember('x',DimOrder);
[a,iy]=ismember('y',DimOrder);
[a,iz]=ismember('z',DimOrder);

Dims(ix)=Nx;
Grids{ix} = gridX;

Dims(iy)=Ny;
Grids{iy} = gridY;

Dims(iz)=Nz;
Grids{iz} = gridZ;

S3 = reshape(S,Dims);

[sortGrid1,I1] = sort(Grids{1});
[sortGrid2,I2] = sort(Grids{2});
[sortGrid3,I3] = sort(Grids{3});

sortGrids = cell(1,3);

sortGrids{1} = sortGrid1;
sortGrids{2} = sortGrid2;
sortGrids{3} = sortGrid3;

S3A = S3(:,:,I3);  % Grid1 - the largest dim, z in matlab
S3B = S3A(:,I2,:); % Grid2 - the middle dim, x in matlab
S3C = S3B(I1,:,:); % Grid3 - the smallest dim, y in matlab

[a,P] = ismember({'y','x','z'},DimOrder);

S3D = permute(S3C,P);

GY = sortGrids{P(1)};
GX = sortGrids{P(2)};
GZ = sortGrids{P(3)};

[X,Y,Z]=meshgrid(GX,GY,GZ);