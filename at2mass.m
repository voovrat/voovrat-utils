function mass = at2mass(at)

a = struct;

a.H = 1;
a.He = 4;
a.Li = 7;
a.Be = 9;
a.B = 11;
a.C = 12;
a.N = 14;
a.O = 16;
a.F = 19;
a.Ne = 20;
a.Na = 23;
a.Mg = 24;
a.Al = 27;
a.Si = 28;
a.P = 31;
a.S = 32;
a.Cl = 35.5;
a.Ar = 40;
a.K = 39;
a.Ca = 40;

mass = cell_get_values( mycellfun(@(x) a.(x),at) );
