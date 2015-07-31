function R=rmsd(x)

S= nanstd(x);
M=nanmean(x);

R=sqrt(S^2 + M^2);
