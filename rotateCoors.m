function [Rot,XYZ1]=rotateCoors(EulerAngles,XYZ)
%
% Volodymyr P Sergiievskyi
% Max Planck Institute for Mathematics in the Sciences
%
% [Rot,XYZ1]=rotateCoors(EulerAngles,XYZ)
%
% Rotate coordinates by Euler Angles
%
%  INPUT PARAMETERS:
%    EulerAngles - euler angles [ rotX, rotY, rotZ ]
%    XYZ - coordinates of the molecule, each COLUMN - coordinates of the
%          atom ( not each ROW!, be careful)
%
%  OUTPUT PARAMETERS:
%    Rot - rotation matrix. To obtain ne coordinates : X'=Rot*X
%    XYZ1 - new coordinates XYZ1 = Rot*XYZ
%
rotX = EulerAngles(1);
rotY = EulerAngles(2);
rotZ = EulerAngles(3);

RotX = [    1   0           0
            0   cos(rotX)    sin(rotX)
            0   -sin(rotX)   cos(rotX)];
        
RotY = [    cos(rotY)  0   -sin(rotY)
            0           1   0
            sin(rotY)  0   cos(rotY)];
        
RotZ = [    cos(rotZ)    sin(rotZ)    0
            -sin(rotZ)   cos(rotZ)    0
            0           0           1];
        
Rot = RotX*RotY*RotZ;

if nargin<2
    return
end

XYZ1 = Rot*XYZ;
