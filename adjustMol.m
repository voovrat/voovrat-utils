function [XYZ_best,grid] = adjustMol(XYZ,Buffer,spacing)


XYZ0 = centrateMol(XYZ);

Ntheta = 10;
Nphi = 20;
Npsi = 8;

dtheta = pi/Ntheta;
dphi = 2*pi/Nphi;
dpsi = 2*pi/Npsi;

Vmin = inf;

for theta = 0:dtheta:pi

%fprintf('%f%% done\n',theta/pi*100);

for phi = 0:dphi:2*pi
for psi = 0:dpsi:2*pi


    Rot3 = [ cos(psi) -sin(psi) 0
             sin(psi)  cos(psi) 0
             0          0       1];

    Rot2 = [ cos(theta)  0    -sin(theta)
             0           1      0
             sin(theta)  0    cos(theta) ];

    Rot1 = [ cos(phi) -sin(phi)  0
             sin(phi)  cos(phi)  0
             0          0        1 ];

    XYZ1 = (Rot1*Rot2*Rot3*XYZ0')';

    L  = (max(XYZ1) - min(XYZ1) ) +  2*Buffer;

    V = prod(L);

    if V<Vmin

        XYZ_best = XYZ1;
        Vmin = V;
        L_best = L;
    end


end
end
end

XYZ_best = centrateMol(XYZ_best);

grid.Nx = ceil(L_best(:,1)/spacing);
grid.Ny = ceil(L_best(:,2)/spacing);
grid.Nz = ceil(L_best(:,3)/spacing);

grid.Lx = L_best(:,1);
grid.Ly = L_best(:,2);
grid.Lz = L_best(:,3);
