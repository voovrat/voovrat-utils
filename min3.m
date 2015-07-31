function [i,j,k]= min3(S)

[Mxy,Ixy] = min(S,[],3);

[Mx,Ix] = min(Mxy,[],2);

[m,iy] = min(Mx);

i = iy;
j = Ix(i);
k = Ixy(i,j);

