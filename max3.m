function [i,j,k]= max3(S)

[Mxy,Ixy] = max(S,[],3);

[Mx,Ix] = max(Mxy,[],2);

[m,iy] = max(Mx);

i = iy;
j = Ix(i);
k = Ixy(i,j);

