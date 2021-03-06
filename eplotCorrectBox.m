function eplotCorrectBox(fname)
%
% Volodymyr P Sergiievskyi, voov.rat@gmail.com
%
% Corrects the bounding box in the eps file generated by the eplot function 
% (sets the bounding box to eWinWidth x eWinHeight
%

global eWinWidth; 
global eWinHeight;

%eWinWidth
%eWinHeight

pt = 25.4/72;  % pt in mm

W=floor(eWinWidth/pt);
H=floor(eWinHeight/pt);

system(['mv ' fname ' eplotCorrectBox.tmp']);
cmd=['cat eplotCorrectBox.tmp | sed ''s/%%BoundingBox:\(.*\)/%%BoundingBox: 0 0 ' num2str(W) ' ' num2str(H) '/g'' > ' fname  ];
system(cmd);

