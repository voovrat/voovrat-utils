function C = plotSpherical2(f,dr,GX,GY,GZ)
%
%  S = plotSpherical2(f,dr,GX,GY,GZ)
%
%  Creates 3d array filled with radial function
%  C - 3d array  (YXZ, as usually in matlab),  
%  GX,GY,GZ - grids
%
%  f - 1d array with grid (1:length(f))*dr
%

M=length(GY);
N=length(GX);
K=length(GZ);

C=zeros(M,N,K);

for i=1:M

    for j=1:N

        for k=1:K
            y = GY(i);
            z=GZ(k);
            x=GX(j);

            r=sqrt(x^2 + y^2 + z^2);


            n = round(r/dr);

            if n>0 && n<length(f) 
                C(i,j,k) = f(n);
            end

            if n==0
                C(i,j,k) = f(1);
            end

        end
    end
end




