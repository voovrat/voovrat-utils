function FC=cutoff(F,Rmax,Rmin)

if nargin<3
    Rmin = -Rmax;
end

FC=F;
FC(F>Rmax) = Rmax;
FC(F<Rmin) = Rmin;