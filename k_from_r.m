function k=k_from_r(r)

dk = pi./(r(end)+r(1));

N=length(r);
k=(1:N)'*dk;
