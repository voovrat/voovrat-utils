function idx = maxn(S)
%
%  Volodymyr P Sergiievskyi, voov.rat@gmail.com
%
%  idx = maxn(S)
%  
%  computes the maximum position in multidimensional array S
%
L = length(size(S));

I_cell = cell(L,1);

M = S;
for dim = L:-1:1

[M,I] = max(M,[],dim);
I_cell{dim} = I;
%size(I)


end

subsidx = struct;
subsidx.type = "()";
idx = zeros(1,L);

idx(1) = I_cell{1};
for dim = 2:L

subsidx.subs = celificate(idx(1:dim-1));

idx(dim) = subsref(I_cell{dim},subsidx);

end





%[Mxy,Ixy] = max(S,[],3);

%[Mx,Ix] = max(Mxy,[],2);

%[m,iy] = max(Mx);

%i = iy;
%j = Ix(i);
%k = Ixy(i,j);

