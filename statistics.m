function [Rmsd,Std,Mean,I]=statistics(Exp,Calc)

M=nanmean(Exp-Calc);
S=nanstd(Exp-Calc);

I = find( abs(Exp-Calc - M)<2*S);
Std = nanstd(Exp(I)-Calc(I));
Mean = nanmean(Exp(I)-Calc(I));
Rmsd = sqrt(Std^2 + Mean^2);



