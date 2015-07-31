function C=celificate(A)
%
%  Volodymyr P. Sergievskyi, Max Planck Institute for Mathematics in the Sciences
%
%  C=celificate(A)
% 
%  Converts matix to the cell matrix of the same size, elements left the same but become cells
%
%

[m,n]=size(A);

C=cell(m,n);

for i=1:m
    for j=1:n
        C{i,j}=A(i,j);
    end
end
