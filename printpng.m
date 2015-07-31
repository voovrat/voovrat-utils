function printpng(fname,fontsize,imgsize)

if nargin<2
	fontsize=16;
end

name = fname(1:end-4)

pngname = fname;
texname = [ name '.tex' ];
jpgname = [ name '.jpg' ];
pdfname = [ name '.pdf' ];
dviname = [ name '.dvi' ];

cmd=['print -depslatexstandalone -F:' num2str(fontsize) ];

if nargin>2

%nargin
%imgsize

cmd = [ cmd ' "-S' num2str(imgsize(1)) ',' num2str(imgsize(2)) '"'];
 

%print('-depslatexstandalone', [ '-F:' num2str(fontsize) ],[ '"-S' num2str(imgsize(1)) ',' num2str(imgsize(2)) '"' ],texname)

%else
%print('-depslatexstandalone', [ '-F:' num2str(fontsize) ],texname)


end

cmd = [ cmd ' ' texname ];
cmd

eval(cmd);

system(['mv ' texname ' ' texname '.0' ]);
system(['head -n1 ' texname '.0 > ' texname ]);
system( [ 'echo ''\usepackage{bm}'' >> ' texname ]);
system(['tail -n+2 ' texname '.0 >> ' texname ]);


system([ 'latex ' texname ])
system([ 'dvipdf ' dviname ])
system([ 'convert -density 300 ' pdfname ' ' jpgname ])
system([ 'convert ' jpgname ' ' fname ])

system([ 'eog ' fname ]);

