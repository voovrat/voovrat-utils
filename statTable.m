function [dta,C] = statTable(Expt,Cols)

N = size(Cols,2);
dta = zeros(6,N);

for i=1:N

    [Rmsd,Std,Mean] = statistics(Expt,Cols(:,i),100);
    
    dta(1,i) = Rmsd;
    dta(2,i) = Std;
    dta(3,i) = -Mean;  % Calc - Exp
    
    I = ~isnan(Cols(:,i));

    dta(4,i) = corr(Expt(I),Cols(I,i));
    dta(5,i) = corr(Expt(I),Cols(I,i))^2;
 
    dta(6,i) = sum(I);


end

rowNames = {'RMSD';'sigma';'M';'r';'r^2';'N'};

C = cellcat2(rowNames,dta);
