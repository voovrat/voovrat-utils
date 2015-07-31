function [Phi,PhiH]=calc_Phi(r,g,density,charge_o,iu,ou)
%
%  V. Sergiievskyi, Max Planck Institute for Mathematics in the Sciences, 2011
%
%  Phi=calc_Phi(r,g,density,charge_o)
%  
%  Calculates potential of the solute atoms in the water solution
%
%  Parameters:  
%    r - vector with distance samples 
%    g - g_sa(r): RDF  functoions of all atoms.
%        columns 1,3,5,...2s-1,...  are rdfs of s-th solute atom with water oxygen
%        columns 2,4,6,...,2s,...  are  rdfs of s-th solute atom with
%        water hydrogen
%    density - number density of a solute ( in Bohr^-3)
%   charge_o - partial charge of water oxygen (without a sign)
%


if nargin<5
    iu=struct('Energy','kcal/mol','Distance','Angstr');
end
if nargin<6
    ou=iu;
end

[DU,EU]=unit_names;

r = r*unit2unit(DU,iu.Distance,'Bohr');

dR = r(2)-r(1);

N = length(r);
Na = size(g,2)/2;

Phi=zeros(N,Na);

for i=1:Na
    ko = 2*i-1;
    kh = 2*i;
    for j = 1:N
        I1 = 1/r(j) * sum( (g(1:j,kh) - g(1:j,ko)).*r(1:j).^2 );
        I2 = sum( ( g(j+1:N,kh) - g(j+1:N,ko) ).*r(j+1:N) );
            
        Phi(j,i) = I1 + I2;
    end
end

PhiH = Phi * 4*pi*density * charge_o * dR;
Phi = PhiH * unit2unit(EU,'Hartree',ou.Energy);
