function M=cellcat2(CellM, RealM)
%
%  Volodymyr P Sergiievsky, Max Planck Institute for Mathematics in the Sciences
%
%   M=cellcat2(Cell, Real)
%
%   Horizantally concatanates cell-matrix Cell and real-matrix Real.
%   Matrices should have the same number of rows
%
% INPUT PARAMETERS:
%
%   Cell - cell matix
%   Real - real matrix
%
% OUTPUT PARAMETER:
%
%  M -  cell matrix: result of concatanation. 
%       If Cell has m row n cols, Real has m row k
%       cols, M has m rows n+k cols. First n cols of M are the same as
%       Cell, last k columns are columns from Real


[m,n1]=size(CellM);
[m,n2]=size(RealM);

M=cell(m,n1+n2);

M(:,1:n1) = CellM;

for i=1:m
    for j2 = 1:n2
        M(i,n1+j2) = { RealM(i,j2)};
    end
    
end
