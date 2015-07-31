function molLabel(X,Y,strings,pn,pv)

N=length(X);

for i=1:N
    t=text(X(i),Y(i),strings{i});
    if nargin>3
        set(t,pn,pv);
    end
end