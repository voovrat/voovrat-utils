function [r1,g1,Nalt]=digitalizeRDF(A,XLim,YLim)
[M,N] =size(A);

alt = cell(N,1);
bottom = cell(N,1);
Nalt = zeros(N,1);

for j=1:N
    
    alt{j} = [];
    
    for i=M-1:-1:1
        if A(i+1,j) && ~A(i,j)
            alt{j} = [ alt{j} i ];
            Nalt(j) = Nalt(j)+1;
        end
        if ~A(i+1,j) && A(i,j)
            bottom{j} = [ bottom{j} i ];
        end
    end
    
end


jmin=1;
while Nalt(jmin)<2
    jmin=jmin+1;
end

while Nalt(jmin)~=2 || Nalt(jmin+1)~=2
    jmin=jmin+1;
end

jmax = N;
while Nalt(jmax)<2
    jmax=jmax-1;
end

while Nalt(jmax)>3 || Nalt(jmax-1)>3
    jmax = jmax -1;
end

jjm=jmin+1;
while Nalt(jjm)==2 || Nalt(jjm+1)==2
    jjm=jjm+1;
end
jmin
jmax
jjm

J = find(Nalt(jjm+1:jmax)==3 ) + jjm;


g1=zeros(size(J));
r1=zeros(size(J));


for k=1:length(J)
    j=J(k);
    imin = (alt{j}(1) + bottom{j}(1))/2;
    imax  = (alt{j}(3) + bottom{j}(3))/2;
    i = (alt{j}(2) + bottom{j}(2))/2;
    
    g1(k) = (i-imin)*(YLim(2)-YLim(1))/(imax - imin) + YLim(1);
    r1(k) = (j-jmin)*(XLim(2)-XLim(1))/(jmax - jmin) + XLim(1);
end

J0 = (jmin:jjm)';

r=[ (J0-jmin)*(XLim(2)-XLim(1))/(jmax - jmin) + XLim(1) ; r1];
g=[zeros(size(J0)); g1];
