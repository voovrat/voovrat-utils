#!/usr/bin/env python
# Andrey I. Frolov, December 2010, MPI MIS, Leipzig
#
# The script converts *.top and a *.pdb file format into *.rismmol. TOP and PDB must be consistent!
# *.top contains the topology and the force field parameters of a molecule (generated by Antechamber and TLeap of AmberTools). Use pdb generated by TLeap.
# *.rismmol is the the toplogy for the RISM-MOL program. (x,y,z,sig,eps,q)

# By default the oarameters in top file are: epsilon[kcal/mol], Rmin/2[A], q[18.2223*|e|]
# in rismmol: x[A], y[A], z[A], epsilon[kcal/mol], sigma[A], q[|e|]

# USAGE: ambertop2rismmol.py  mol.top  mol.pdb  mol.rismmol
#  converts the data
#
# USAGE2: ambertop2rismmol.py  mol.top  mol.pdb  mol.rismmol CHECK
#  converts the data and prints additional output into stdout 

import sys, numpy

fname=sys.argv[1]
fpdb=sys.argv[2]
ofname=sys.argv[3]
try:
    key=sys.argv[4]
except:
    key=""

ifile=open(fname,"r")
ifpdb=open(fpdb,"r")
ofile=open(ofname,"w")

lines=ifile.readlines()

def GetArrayFromAmberTopology(lines,field):
# The fuction takes a field name, reads appropriat format of the data, and fill the data into an array. 
# Gets an array with lines of the file. field - filed name.
    OutArr=[]
    for ind in range(len(lines)):
        line=lines[ind]
        ln=line.split()
        if (len(ln)<=1): continue
        if (ln[1] == field):
            # Finding the length of entries in the array
            fmt=lines[ind+1][:-1]; fmt=fmt.strip(); fmt=fmt[:-1]; fmt=fmt.split('('); fmt=fmt[1]; fmt=fmt.split('.'); fmt=fmt[0]
            for i in range(len(fmt)):
                try:
                    float(fmt[i])
                except:
                    break
            fmt=int(fmt[i+1:])
            #print field,"format", fmt


            # Filling in the array
            tmpind=ind+2
            while lines[tmpind][0]!="%":
                line2 = lines[tmpind]; l=len(line2[:-1])
                for j in range(0,l,fmt):
                     OutArr.append(line2[j:j+fmt])
                tmpind+=1
    return OutArr


# READ IN NESESSARY DATA
ATOM_NAME = GetArrayFromAmberTopology(lines,'ATOM_NAME')
CHARGE = GetArrayFromAmberTopology(lines,'CHARGE')
ATOM_TYPE_INDEX = GetArrayFromAmberTopology(lines,'ATOM_TYPE_INDEX')
LENNARD_JONES_ACOEF = GetArrayFromAmberTopology(lines,'LENNARD_JONES_ACOEF')
LENNARD_JONES_BCOEF = GetArrayFromAmberTopology(lines,'LENNARD_JONES_BCOEF')
AMBER_ATOM_TYPE = GetArrayFromAmberTopology(lines,'AMBER_ATOM_TYPE')

#print ATOM_NAME
#print CHARGE
#print ATOM_TYPE_INDEX
#print LENNARD_JONES_ACOEF
#print LENNARD_JONES_BCOEF
#print AMBER_ATOM_TYPE

# CALCULATING SIG[A] AND EPSILON[kcal/mol] OUT OF A and B
Aij=LENNARD_JONES_ACOEF
Bij=LENNARD_JONES_BCOEF
rmin2ij=[]; epsij=[]
for j in range(len(Aij)):
    if (float(Bij[j]) != 0 and float(Aij[j] != 0)):
        rmin2ij.append( 2**0.1666666666666666/2*(float(Aij[j])/float(Bij[j]))**0.166666666666666666666)
        epsij.append((float(Bij[j])**2/4/float(Aij[j])))
    else:
        rmin2ij.append(0.0)
        epsij.append(0.0)
        
#print rmin2ij, epsij

# CHOOSING ONLY sigii and epsii terms, throwing away ij terms. ONLY ATOM TYPES!!!
NAtTy=len(list(set(ATOM_TYPE_INDEX)))
rAtType=[]; eAtType=[];
cnt=-1;
for i in range(NAtTy):
    for j in range(i+1):
        cnt+=1
    rAtType.append(rmin2ij[cnt])
    eAtType.append(epsij[cnt])

#print rAtType, eAtType
    #print ind

# ASSIGNING PARAMETERS FOM ATOM TPES TO ATOMS
NAtom=len(ATOM_TYPE_INDEX)
rA=[]; sA=[]; eA=[]; q=[];
for i in range(NAtom):
    ind=int(ATOM_TYPE_INDEX[i])
    #print ind
    rA.append(rAtType[ind-1])
    #sigma
    sA.append(rAtType[ind-1]*2/2**0.16666666666666666)
    eA.append(eAtType[ind-1])
    q.append(float(CHARGE[i])/18.2223)

#print
#print rA, eA



# READING PDB COORDINATES FROM THE PDB FILE
x=[];y=[];z=[]; A=[];
for line in ifpdb:
    ln=line.split()
    if len(ln) < 3: continue
    if ln[0]=='ATOM': 
        A.append(ln[2])
        line2=line[31:55]
        #print line2
        ln2=line2.split()
        x.append(ln2[0]);y.append(ln2[1]);z.append(ln2[2]);


# PRINTING WARNING
if (sum(q) >= 1e-8): print "WARNING!!! sum(q)>1e-8 : = ", sum(q)

if key=='CHECK':
    print "iAtom name from pdb, GAFF atom type from topology, x,y,z from pdb, rmin2,sigma,eps,q from topology"
    print "Units: Angstr, kcal/mol, e"
    for i in range(NAtom):
        print " %5s  %5s %10s %10s %10s %15.9f %15.9f %15.9f %15.9f " % (A[i],AMBER_ATOM_TYPE[i],x[i],y[i],z[i],rA[i],sA[i],eA[i],q[i])
        ofile.write( " %10s %10s %10s %15.9f %15.9f %15.9f \n" % (x[i],y[i],z[i],sA[i],eA[i],q[i]))
else:
    for i in range(NAtom):
        ofile.write( " %10s %10s %10s %15.9f %15.9f %15.9f \n" % (x[i],y[i],z[i],sA[i],eA[i],q[i]))
    








#for j in range(len(LENNARD_JONES_ACOEF)):
#    for i in range(j):
#        print 




#%VERSION  VERSION_STAMP = V0001.000  DATE = 09/16/10  18:20:17                  
#%FLAG TITLE                                                                     
#%FORMAT(20a4)                                                                   
#MOL                                                                             
#%FLAG POINTERS                                                                  
#%FORMAT(10I8)                                                                   
#       6       4       4       1       7       0       3       0       0       0
#      16       1       1       0       0       3       3       1       4       0
#       0       0       0       0       0       0       0       0       6       0
#       0
#%FLAG ATOM_NAME                                                                 
#%FORMAT(20a4)                                                                   
#C1  H2  H3  H4  O1  H1  
#%FLAG CHARGE                                                                    
#%FORMAT(5E16.8)                                                                 
#  2.12654241E+00  1.06964901E+00  2.49645510E-01  2.49645510E-01 -1.09115132E+01
#  7.21603080E+00
#%FLAG MASS                                                                      
#%FORMAT(5E16.8)                                                                 
#  1.20100000E+01  1.00800000E+00  1.00800000E+00  1.00800000E+00  1.60000000E+01
#  1.00800000E+00
#%FLAG ATOM_TYPE_INDEX                                                           
#%FORMAT(10I8)                                                                   
#       1       2       2       2       3       4
#%FLAG NUMBER_EXCLUDED_ATOMS                                                     
#%FORMAT(10I8)                                                                   
#       5       4       3       2       1       1
#%FLAG NONBONDED_PARM_INDEX                                                      
#%FORMAT(10I8)                                                                   
#       1       2       4       7       2       3       5       8       4       5
#       6       9       7       8       9      10
#%FLAG RESIDUE_LABEL                                                             
#%FORMAT(20a4)                                                                   
#MOL 
#%FLAG RESIDUE_POINTER                                                           
#%FORMAT(10I8)                                                                   
#       1
#%FLAG BOND_FORCE_CONSTANT                                                       
#%FORMAT(5E16.8)                                                                 
#  3.35900000E+02  3.14100000E+02  3.69600000E+02
#%FLAG BOND_EQUIL_VALUE                                                          
#%FORMAT(5E16.8)                                                                 
#  1.09300000E+00  1.42600000E+00  9.74000000E-01
#%FLAG ANGLE_FORCE_CONSTANT                                                      
#%FORMAT(5E16.8)                                                                 
#  4.70900000E+01  3.91800000E+01  5.09700000E+01
#%FLAG ANGLE_EQUIL_VALUE                                                         
#%FORMAT(5E16.8)                                                                 
#  1.88774893E+00  1.91200902E+00  1.91776860E+00
#%FLAG DIHEDRAL_FORCE_CONSTANT                                                   
#%FORMAT(5E16.8)                                                                 
#  1.66666667E-01
#%FLAG DIHEDRAL_PERIODICITY                                                      
#%FORMAT(5E16.8)                                                                 
#  3.00000000E+00
#%FLAG DIHEDRAL_PHASE                                                            
#%FORMAT(5E16.8)                                                                 
#  0.00000000E+00
#%FLAG SOLTY                                                                     
#%FORMAT(5E16.8)                                                                 
#  0.00000000E+00  0.00000000E+00  0.00000000E+00  0.00000000E+00
#%FLAG LENNARD_JONES_ACOEF                                                       
#%FORMAT(5E16.8)                                                                 
#  1.04308023E+06  6.78771368E+04  3.25969625E+03  7.91544157E+05  4.66922514E+04
#  5.81803229E+05  0.00000000E+00  0.00000000E+00  0.00000000E+00  0.00000000E+00
#%FLAG LENNARD_JONES_BCOEF                                                       
#%FORMAT(5E16.8)                                                                 
#  6.75612247E+02  1.06076943E+02  1.43076527E+01  6.93079947E+02  1.03606917E+02
#  6.99746810E+02  0.00000000E+00  0.00000000E+00  0.00000000E+00  0.00000000E+00
#%FLAG BONDS_INC_HYDROGEN                                                        
#%FORMAT(10I8)                                                                   
#       0       3       1       0       6       1       0       9       1      12
#      15       3
#%FLAG BONDS_WITHOUT_HYDROGEN                                                    
#%FORMAT(10I8)                                                                   
#       0      12       2
#%FLAG ANGLES_INC_HYDROGEN                                                       
#%FORMAT(10I8)                                                                   
#       0      12      15       1       3       0       6       2       3       0
#       9       2       3       0      12       3       6       0       9       2
#       6       0      12       3       9       0      12       3
#%FLAG ANGLES_WITHOUT_HYDROGEN                                                   
#%FORMAT(10I8)                                                                   
#
#%FLAG DIHEDRALS_INC_HYDROGEN                                                    
#%FORMAT(10I8)                                                                   
#       3       0      12      15       1       6       0      12      15       1
#       9       0      12      15       1
#%FLAG DIHEDRALS_WITHOUT_HYDROGEN                                                
#%FORMAT(10I8)                                                                   
#
#%FLAG EXCLUDED_ATOMS_LIST                                                       
#%FORMAT(10I8)                                                                   
#       2       3       4       5       6       3       4       5       6       4
#       5       6       5       6       6       0
#%FLAG HBOND_ACOEF                                                               
#%FORMAT(5E16.8)                                                                 
#
#%FLAG HBOND_BCOEF                                                               
#%FORMAT(5E16.8)                                                                 
#
#%FLAG HBCUT                                                                     
#%FORMAT(5E16.8)                                                                 
#
#%FLAG AMBER_ATOM_TYPE                                                           
#%FORMAT(20a4)                                                                   
#c3  h1  h1  h1  oh  ho  
#%FLAG TREE_CHAIN_CLASSIFICATION                                                 
#%FORMAT(20a4)                                                                   
#M   E   E   E   M   E   
#%FLAG JOIN_ARRAY                                                                
#%FORMAT(10I8)                                                                   
#       0       0       0       0       0       0
#%FLAG IROTAT                                                                    
#%FORMAT(10I8)                                                                   
#       0       0       0       0       0       0
#%FLAG RADIUS_SET                                                                
#%FORMAT(1a80)                                                                   
#modified Bondi radii (mbondi)                                                   
#%FLAG RADII                                                                     
#%FORMAT(5E16.8)                                                                 
#  1.70000000E+00  1.30000000E+00  1.30000000E+00  1.30000000E+00  1.50000000E+00
#  8.00000000E-01
#%FLAG SCREEN                                                                    
#%FORMAT(5E16.8)                                                                 
#  7.20000000E-01  8.50000000E-01  8.50000000E-01  8.50000000E-01  8.50000000E-01
#  8.50000000E-01


