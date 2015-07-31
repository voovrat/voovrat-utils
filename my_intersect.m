function [C,IA,IB]=my_intersect(A,B,thres)

if nargin<3
    thres = 1e-6;
end

C = [];
IA=[];
IB=[];

for i=1:length(A)

    for j=1:length(B)

        if abs(A(i) - B(j)) < thres
            C = [ C; A(i) ];
            IA = [ IA; i];
            IB = [ IB; j];
        end

    end


end


