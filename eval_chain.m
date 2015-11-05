function result = eval_chain(Commands)
%
%   result = eval_chain(Commands)
%
% evaluates statements in Commands
% result variable should be assigned inside the list
% The only purpose - to use with automatic functions (e.g. mycellfun ) 
%

N = length(Commands);

for i=1:N
   eval([ Commands{i} ';' ])

end
