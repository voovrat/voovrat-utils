function V = symmatrix_to_num(C)

[m,n]=size(C);

V = zeros(m,n);

for i=1:m
  for j=1:n

     V(i,j) = str2num(C{i,j});

  end
end
