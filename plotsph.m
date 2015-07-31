function sh=plotsph(X,Y,Z,R,NVert)

N=length(X);

if nargin<5
    NVert=20;
end


[XS,YS,ZS]=sphere(NVert);

XP=R*XS+X(1);
YP=R*YS+Y(1);
ZP=R*ZS+Z(1);


for i=2:N

    XP=[XP; R*(XS+X(i))];
    YP=[YP; R*(YS+Y(i))];
    ZP=[ZP; R*(ZS+Z(i))];

end

sh=surf(XP,YP,ZP);