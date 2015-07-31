import sys;

if len(sys.argv)<=1:

	print("Usage: multicol  file1 file2 ...\n");
	print("The program prints the columns from the files as a one table (column by column, tab separated");
	quit();

def removeSpecChars(line):
	N=len(line);
	r='';
	for i in range(N):
		if ord(line[i])>=32:
			r=r+line[i];

	return r;


a=[];

N=len(sys.argv)-1;

for i in range(1,N+1):
	fname=sys.argv[i];
	f=open(fname,"r");
	S=f.readlines();
	a.append(S);
	f.close();

#print(a);

# M rows, N columns, a[i][j] is the value at the i-th column, j-th row.
M = len(a[0]);

Len={};

# find the lengths of columns
for i in range(N):
	Len[i]=0;
	for j in range(M):
		L=len(a[i][j]);
		if L>Len[i]:
			Len[i]=L

for j in range(M):
	line='';
	for i in range(N):
		line=line+ ( ( "%-"+str(Len[i])+"s") % removeSpecChars(a[i][j]) )
		if i<N-1:
			line=line+"  ";
	print line;



