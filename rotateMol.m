function XYZ2=rotateMol(XYZ)
%
%  XYZ2 = rotateMol(XYZ)
%
%  rotate the coordinated in a most optimal way 
% (to maximize buffer)
%  NB: coordinates should be previously centrated with centrateMol
%  Also: may be repeated several times (centrate-rotate-centrate-rotate ... )


% find the most remote molecule

R = sqrt(sum(XYZ.^2,2));

[Rmax,imax] = max(R);


cos_theta = XYZ(imax,3)/R(imax);
theta = acos(cos_theta);

phi = atan2(XYZ(imax,2),XYZ(imax,1));



dtheta = pi/4 - theta;
dphi = pi/4 -phi;

Rot1 = [ cos(phi)  sin(phi) 0;    
        -sin(phi) cos(phi) 0; 
         0          0        1];  % rotate to phi=0 (|| Ox)

XYZA = (Rot1*XYZ')';

%   plot(XYZ(:,1),XYZ(:,2),'s',XYZA(:,1),XYZA(:,2),'o'),axis equal
%   plot(XYZ(:,1),XYZ(:,3),'s',XYZA(:,1),XYZA(:,3),'o'),axis equal
 
%  acos(XYZA(imax,3)/R(imax)) /pi*180
%  atan2(XYZA(imax,2),XYZA(imax,1))/pi*180

Rot2 = [ cos(dtheta) 0  sin(dtheta);
         0           1  0;
        -sin(dtheta) 0  cos(dtheta) ]; % rotate by -dtheta over y

XYZB = (Rot2*XYZA')';

%   plot(XYZA(:,1),XYZA(:,2),'s',XYZB(:,1),XYZB(:,2),'o'),axis equal
%   plot(XYZA(:,1),XYZA(:,3),'s',XYZB(:,1),XYZB(:,3),'o'),axis equal

%  acos(XYZB(imax,3)/R(imax)) /pi*180
%  atan2(XYZB(imax,2),XYZB(imax,1))/pi*180

Rot3 = [ cos(pi/4)  -sin(pi/4) 0;    
        sin(pi/4) cos(pi/4) 0; 
         0          0        1];  % rotate to phi=pi/4

XYZ2 = (Rot3*XYZB')';

%    plot(XYZB(:,1),XYZB(:,2),'s',XYZ2(:,1),XYZ2(:,2),'o'),axis equal
%    plot(XYZB(:,1),XYZB(:,3),'s',XYZ2(:,1),XYZ2(:,3),'o'),axis equal
%
%   acos(XYZ2(imax,3)/R(imax)) /pi*180
%   atan2(XYZ2(imax,2),XYZ2(imax,1))/pi*180

%XYZ2 = (RotZ * RotY * XYZ')';


%cos_theta2 = XYZ2(imax,3)/R(imax);
%theta2 = acos(cos_theta2)

%phi2 = atan2(XYZ2(imax,2),XYZ2(imax,1))

%[ phi  dphi phi2]/pi*180
%[ theta dtheta theta2]/pi*180

