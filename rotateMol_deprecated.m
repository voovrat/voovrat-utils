function XYZ2=rotateMol_deprecated(XYZ)
%
%  XYZ2 = rotateMol(XYZ)
%
%  rotate the coordinated in a most optimal way 
% (to maximize buffer)
%  NB: coordinates should be reviously centrated with centrateMol
%  Also: may be repeated several times (centrate-rotate-centrate-rotate ... )


% Step 2: find the atom spherical coordinated

R = sqrt( sum(XYZ.^2,2));

SinTheta = XYZ(:,3)./R; 
theta = asin(SinTheta);
phi = atan2(XYZ(:,2), XYZ(:,1));

phiX = atan(XYZ(:,2)./XYZ(:,1));

phiX(isnan(phiX))=0;

J = abs(phi-phiX)<1e-6;
NJ = abs(phi - phiX )>1e-6;

% check that everything is ok: 

%X = R .* cos(theta).*cos(phi);
%Y = R .* cos(theta).*sin(phi);
%Z = R .* sin(theta);

R1 = R;
R1(NJ) = -R(NJ);
thetaX = theta;
thetaX(NJ) = -theta(NJ);

X1 = R1 .* cos(thetaX).*cos(phiX);
Y1 = R1 .* cos(thetaX).*sin(phiX);
Z1 = R1 .* sin(thetaX);

%sum(abs([ X Y Z ] - XYZ))
%[X1(end,:) Y1(end,:) Z1(end,:) XYZ(end,:)]

[X1 Y1 Z1] - XYZ;
% find the most remote atom

[Rmax,Imax] = max(R);

% find the transform which rotates the coordinates to the right corner (1,1,1)

%xyz1 = XYZ(Imax,:)'/R1;
%xyz2 = [1 1 1]'/sqrt(3);

% Now:

%  A*xyz1 = xyz2  ->
%  A*[0 0 0]' = [0 0 0]'
%



theta1 = thetaX(Imax);
phi1 = phiX(Imax);

% rotate this (and all the atoms) to 
% the corner direction: theta2 = pi/4, phi2=pi/4

theta2 = pi/4;
phi2=pi/4;

%dtheta = theta2-theta1;
%dphi = phi2 - phi1;

dtheta = theta2 - theta1;
dphi = phi2 - phi1;

%X2 = R .* cos(theta + dtheta).*cos(phi+dphi);
%Y2 = R .* cos(theta + dtheta).*sin(phi+dphi);
%Z2 = R .* sin(theta + dtheta);

%X2 = R1 .* cos(thetaX + dtheta ).*cos(phiX);%.*cos(phiX+dphi );   %.*cos(phi+dphi);
%Y2 = R1 .* cos(thetaX + dtheta).*sin(phiX);%.*sin(phiX+dphi );%.*sin(phi+dphi);
%Z2 = R1 .* sin(thetaX + dtheta);

%dtheta=0;

X2 = R1 .* cos(thetaX + dtheta ).*cos(phiX);%.*cos(phiX+dphi );   %.*cos(phi+dphi);
Y2 = R1 .* cos(thetaX + dtheta).*sin(phiX);%.*sin(phiX+dphi );%.*sin(phi+dphi);
Z2 = R1 .* sin(thetaX + dtheta);



XYZ2 = [ X2 Y2 Z2 ];

%S2 = [XYZ2 S(:,4:6)];
%S3 = [S ; S2];

%system('cat undecan_2_one.atm undecan_2_one.atm > out.atm');

%save -ascii out.rism S3

