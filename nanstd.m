function S=nanstd(X)

[m,n] = size(X);

S=zeros(1,n);

for i=1:n
    I = find(~isnan(X(:,i)));
    if ~isempty(I)
            S(i) = std(X(I,i));
    else
	    S(i) = NaN;
    end
end


