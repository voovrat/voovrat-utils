function X=stat_inefficiency(LL)

X=zeros(size(LL));

for i=2:length(LL)
   X(i) = std(block_mean(LL,i))*sqrt(i) / std(LL);
end
