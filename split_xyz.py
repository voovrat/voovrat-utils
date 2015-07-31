from sys import *
import re

lines = stdin.readlines();

N = len(lines);

i=0;
while i<N-1:	
	while not re.match("[ ]*[0-9]+[ ]*",lines[i]):
		i=i+1;		
		if i>=N:
			quit()

	n = int(lines[i]); 
	i=i+1;
	print "n="+str(n)	
	xname = lines[i]; 
	i=i+1;
	name = xname.split()[0];
	print "name="+name
	fout = open(name,"w");
	fout.writelines(lines[i-2:i+n]);
	fout.close();
	i=i+n;
	#i=i+1; # *****

		
	
