function shl=plot_mol(XYZ,Sigma,Color,NVert)

if nargin<4
    NVert=100;
end

L=size(XYZ,1);

XP=[]; YP=[]; ZP=[];

shl=zeros(L,1);

for i=1:L
   
    x=XYZ(i,1);
    y=XYZ(i,2);
    z=XYZ(i,3);
    
    shl(i) = plotsph(y,x,z,Sigma(i)/2,NVert);
    hold on
    
    set(shl(i),'FaceColor',Color(i,:));
    set(shl(i),'LineStyle','none');
end

axis equal
light
set(shl,'FaceLighting','phong')