function [Rot,XYZ1]=rotateCoorsZYZ(EulerAngles,XYZ)
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
theta = EulerAngles(1);
phi = EulerAngles(2);
psi  = EulerAngles(3);

RotPsi = [    cos(psi)   -sin(psi) 0
            sin(psi)   cos(psi)  0
            0               0      1];
        
RotTheta = [    cos(theta)  0   sin(theta)
            0           1   0
            -sin(theta)  0   cos(theta)];
        
RotPhi = [    cos(phi)    -sin(phi)    0
            sin(phi)   cos(phi)    0
            0           0           1];
        
Rot = RotPhi*RotTheta*RotPsi;

if nargin<2
    return
end

XYZ1 = Rot*XYZ;
