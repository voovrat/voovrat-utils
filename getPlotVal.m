function y0=getPlotVal(X,Y,x0)


I = (1:length(X));

IMax = find(X>x0);
IMin = find(X<x0);


i0 = max(IMin);
i1 = min(IMax);

lambda = (x0 - X(i0))/(X(i1)- X(i0));

y0 = lambda*Y(i1) + (1-lambda)*Y(i0);

