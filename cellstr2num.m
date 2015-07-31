function A = cellstr2num(C)
%
% A = cellstr2num(S)
%  converts each of cell values to numbers and returns a numeric matrix

[M,N] = size(C);

A = zeros(M,N);

for i=1:M
for j=1:N

    a = str2num(C{i,j});
    if isempty(a)
        A(i,j) = NaN;
    else
        A(i,j) = a;
    end

end
end



