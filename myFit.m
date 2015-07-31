function a=myFit(X,Z,fn,a0)

minfn =@(a)(sum( (fn(a,X) - Z).^2 ) );
a = fminunc(@(a)(minfn(a)),a0);

