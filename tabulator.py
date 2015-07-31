#run_python tabulator.py $*

exit


import sys
from moldb import str2val

#
# Makes the table look pretty))
#


if __name__ == '__main__':
	

	nfmt='{0:8.5}';

	if len(sys.argv)>1:
		nfmt='{0:'+sys.argv[1]+'}';

	s=sys.stdin.read().split('\n');


	lines=[];
	lens={};

	for line in s:
#		print line
		words = line.split();

#		print words
	
		for n in range(len(words)):
			w=str2val(words[n]);
			if type(w) is float:
				try:
					w = nfmt.format(w);
				except ValueError:
					print 'ERROR'+nfmt+str(w)

			if type(w) is int:
				w=str(w);

			L = len(w);
			
			if not n in lens or lens[n]<L:
				lens[n] = L;

		lines.append(words);

	fmt={};
	for i in lens.keys():
		fmt[i] = '{0:'+str(lens[i]) + '}';

#	print fmt

	for words in lines:
		s='';
		for n in range(len(words)):
			w=str2val(words[n]);
			if type(w) is float:
				w=nfmt.format(w);
			if type(w) is int:
				w=str(w);
			s+=fmt[n].format(w)+' ';

		print s
