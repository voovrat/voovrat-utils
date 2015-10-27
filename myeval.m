function result=myeval(param,command)
%
% command  in the form 'result=....' OR
%  'a=param(1);b=param(2);result=(a+b)^3;' etc...
%

eval(command)
