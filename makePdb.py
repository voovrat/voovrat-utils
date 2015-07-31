import sys

usage="""
Usage:  makePdb file.coors  atomtypes.txt
"""

args=sys.argv[1:]

if len(args)<2:
	print usage
	quit()

f=open(args[0])
coors=f.read().splitlines();
f.close()


f=open(args[1]);
atoms=f.read().splitlines();
f.close();

#description from http://deposit.rcsb.org/adit/docs/pdb_atom_format.html

for i in range(len(atoms)):
	words=coors[i].split();	
	x=float(words[0]);
	y=float(words[1])
	z=float(words[2]);

	#1 -  6        Record name     "ATOM  "                                            
	sys.stdout.write("%6s" % "ATOM  ");
	
	#7 - 11        Integer         Atom serial number.                   
	sys.stdout.write("%5d" % (i+1) );
		

	### Where is 12??? 
	sys.stdout.write(" ");


	#13 - 16        Atom            Atom name.                            
	# it is written 13-16, but in exapmle it starts from 14
	# " " + 3s , but left justified ->
	sys.stdout.write(" ");
	sys.stdout.write( atoms[i]);
	fmt = "%" + str(3-len(atoms[i])) + "s";
	sys.stdout.write( fmt %  " ");
	
	#17             Character       Alternate location indicator.         
	sys.stdout.write("%1s" % " ");
	

	#18 - 20        Residue name    Residue name.                         
	sys.stdout.write("%3s" % "MOL")

	#??? Where is 21 ????
	sys.stdout.write(" ");
	
	#22             Character       Chain identifier.                     
	sys.stdout.write("%1s" % "A");
	
	#23 - 26        Integer         Residue sequence number.              
	sys.stdout.write( "%4d" % 1 );
	
	#27             AChar           Code for insertion of residues.       
	sys.stdout.write( "%1s" % " ");

	### Where Are 28-30????
	sys.stdout.write("%3s" % " ");
	
	#31 - 38        Real(8.3)       Orthogonal coordinates for X in Angstroms.                       
	sys.stdout.write("%8.3f" % x);
	
	#39 - 46        Real(8.3)       Orthogonal coordinates for Y in Angstroms.
	sys.stdout.write( "%8.3f" % y );
	
	#47 - 54        Real(8.3)       Orthogonal coordinates for Z in Angstroms.
	sys.stdout.write("%8.3f" % z );
	
	#55 - 60        Real(6.2)       Occupancy.                            
	sys.stdout.write( "%6.2f" % 1.0);
	
	#61 - 66        Real(6.2)       Temperature factor (Default = 0.0).                   
	sys.stdout.write( "%6.2f" % 0.0 );

	# Where are 67-72 (6s)?
	sys.stdout.write("%6s" % " ");
	
	#73 - 76        LString(4)      Segment identifier, left-justified.   
	sys.stdout.write( "%4s" % "A1  ");
	
	#77 - 78        LString(2)      Element symbol, right-justified.      
	sys.stdout.write("%2s" % atoms[i]);
	
	#79 - 80        LString(2)      Charge on the atom.       
	sys.stdout.write("%2s" % " ");

	sys.stdout.write("\n");	




Example="""

         1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
ATOM    145  N   VAL A  25      32.433  16.336  57.540  1.00 11.92      A1   N
ATOM    146  CA  VAL A  25      31.132  16.439  58.160  1.00 11.85      A1   C
ATOM    147  C   VAL A  25      30.447  15.105  58.363  1.00 12.34      A1   C
ATOM    148  O   VAL A  25      29.520  15.059  59.174  1.00 15.65      A1   O
ATOM    149  CB AVAL A  25      30.385  17.437  57.230  0.28 13.88      A1   C
ATOM    150  CB BVAL A  25      30.166  17.399  57.373  0.72 15.41      A1   C
ATOM    151  CG1AVAL A  25      28.870  17.401  57.336  0.28 12.64      A1   C
ATOM    152  CG1BVAL A  25      30.805  18.788  57.449  0.72 15.11      A1   C
ATOM    153  CG2AVAL A  25      30.835  18.826  57.661  0.28 13.58      A1   C
ATOM    154  CG2BVAL A  25      29.909  16.996  55.922  0.72 13.25      A1   C
"""

