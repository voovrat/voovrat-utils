import os

#def clusters( oxy_list, cluster_size )
from math import sqrt

def sort_indeces(lst):
   
   a = []
   for i in range(len(lst)):
      a.append( (lst[i],i) )
   
   a.sort()
   
   idx=[]
   for p in a:
      idx.append(p[1])

   return idx


def reindex(lst,idx):

   relist=[]
   for i in idx:
      relist.append(lst[i])

   return relist


def oxylist2atomlist(oxy_list):
   atom_list=[]
   for i in oxy_list:
      atom_list.append(i-1)
      atom_list.append(i)
      atom_list.append(i+1)

   return atom_list


def list_addscalar(lst, scalar):
   for i in range(len(lst)):
      lst[i] = lst[i] + scalar

def list_subscalar(lst,scalar):
   list_addscalar(lst,-scalar);


def neglist(lst,N):
    
     ones = []; 
     for i in range(N):
         ones.append(True)

     for i in lst:
         ones[i] = False

     neglist=[]
     for i in range(len(ones)):
         if ones[i]:
            neglist.append(i)

     return neglist


class XYZ:
   def __init__(self):
      self.clear()

   def clear(self):
      self.x = []
      self.y = []
      self.z = []
      self.atoms = []
     
   def __len__(self):
      return len(self.atoms)   

   def copy(self):
      cp = XYZ()
      cp.append(self)
      return cp

   def __add__(self,other):
      r = self.copy()
      r.append(other)
      return r

   def read(self,fname):
      f = open(fname,'r')
      L = f.readlines();

      N = int(L[0]);

      for i in range(2,N+2):
         words = L[i].split();
         self.atoms.append( words[0] );
         self.x.append( float(words[1]) );
         self.y.append( float(words[2]) );
         self.z.append( float(words[3]) );

      f.close()
         
   def xyz(self):
      N = len(self.x);
      xyz=[];
   
      for i in range(N):   
         xyz.append([self.x[i],self.y[i],self.z[i] ]);

      return xyz

   def axyz(self):

      N=len(self.x);
      axyz=[];
      for i in range(N):
         axyz.append( [self.atoms[i], self.x[i], self.y[i], self.z[i]]);
 
      return axyz

   def write(self,fname,sysname=""):
      f = open(fname,'w');
      
      if sysname == "":
         sysname="molecules"

      N = len(self.atoms)

      f.write( str(N) + "\n");
      f.write( sysname + "\n");
      for i in range(N):
         f.write( "%s %f %f %f\n" % (self.atoms[i], self.x[i], self.y[i], self.z[i]) )
      f.close()

   def set_axyz(self,axyz):
      self.clear()
      N = len(axyz);
      for l in axyz:
         self.atoms.append(l[0]);
         self.x.append(l[1]);
         self.y.append(l[2]);
         self.z.append(l[3]);
 
   def remove(self,idx_list):
      if type(idx_list) != list:
         idx_list = [idx_list]
 
      for i in idx_list:
         self.atoms = self.atoms[:i] + self.atoms[i+1:]
         self.x = self.x[:i] + self.x[i+1:]
         self.y = self.y[:i] + self.y[i+1:]
         self.z = self.z[:i] + self.z[i+1:]

   def append(self,xyz_obj):
         self.atoms = self.atoms + xyz_obj.atoms
         self.x = self.x + xyz_obj.x
         self.y = self.y + xyz_obj.y
         self.z = self.z + xyz_obj.z

   def select(self,atom_list):
     S = XYZ()
     for i in atom_list:
        S.atoms.append(self.atoms[i])
        S.x.append(self.x[i])
        S.y.append(self.y[i])
        S.z.append(self.z[i])

     return S

   def unselect(self,atom_list):
      return self.select(neglist(atom_list,len(self.atoms)))

   def select_oxygens(self,oxy_list):
      return self.select( oxylist2atomlist(oxy_list))

   def unselect_oxygens(self,oxy_list):
      return self.unselect( oxylist2atomlist(oxy_list))
         
   def show(self):
      self.write('tmp.xyz')
      os.system('show_labels tmp.xyz >/dev/null 2>/dev/null &')

   def oxylist(self):
      oxy_list = []
      for i in range(len(self)):
         if self.atoms[i] == 'O':
            oxy_list.append(i+1)      

      return oxy_list

   def centrate(self):

      cp = XYZ()
      cp.append(self)

      maxx = max(self.x)
      minx = min(self.x)
      list_subscalar(cp.x, (maxx + minx)/2);

      maxy = max(self.y)
      miny = min(self.y)
      list_subscalar(cp.y, (maxy + miny)/2);

      maxz = max(self.z)
      minz = min(self.z)
      list_subscalar(cp.z, (maxz + minz)/2);

      return cp

   def proton_index(self):  # finds the index of the hydrogen which is not one of 2 hydrogens which follow oxygen
# e.g  O H H H --> third H is a "proton"
      not_proton_counter = 0
      for i in range(len(self)):
         if self.atoms[i]=='O': 
            not_proton_counter = 2
         if self.atoms[i]=='H':
            not_proton_counter-=1
            if not_proton_counter < 0:
               return i

   def proton(self):  # finds the 
      p= self.select( [ self.proton_index() ] )
      return p
      
   def oxydist_list(self,index):

      dlist = []
      x0 = self.x[index]
      y0 = self.y[index]
      z0 = self.z[index]

      for i in self.oxylist():
         x1 = self.x[i-1]
         y1 = self.y[i-1]
         z1 = self.z[i-1]

         d = sqrt( (x0-x1)**2 + (y0-y1)**2 + (z0-z1)**2 )
         dlist.append(d)

      return dlist

   def dist_n_oxy(self,index):
      dlist = self.oxydist_list(index)
      
      I=sort_indeces(dlist)
      dd = reindex(dlist,I)
      oxdd = reindex(self.oxylist(),I)

      return (dd,oxdd)

   def select_oxy_n_me(self,ox,index):
      
      alist = oxylist2atomlist(ox)

      if not (index in alist):
         alist.append(index)

      return self.select(alist)


   def neighb_within_distance(self,index,R):

      dd,oxdd = self.dist_n_oxy(index)

      ox = []
      for i in range(len(dd)):
        if dd[i] > R:
           break
        ox.append(oxdd[i])
 
      return self.select_oxy_n_me(ox,index)

   def nearliest_neighb(self,index,count):

      dd,oxdd = self.dist_n_oxy(index)
      ox = oxdd[0:count]
      return self.select_oxy_n_me(ox,index)

   def insert_cluster(self,c0,R):

      slf = self.centrate()
      c =c0.centrate()

      cc = XYZ()
      cc.append(c)

      R2 = R*R

      for i in slf.oxylist():
         x0 = slf.x[i-1]
         y0 = slf.y[i-1]
         z0 = slf.z[i-1]

         ok = True

         for j in range(len(c)):
            x1 = c.x[j]
            y1 = c.y[j]
            z1 = c.z[j]

            rr2 = (x0-x1)**2 + (y0-y1)**2 + (z0-z1)**2

            if rr2<R2:
               ok = False
               break

         if ok:
            cc.x += slf.x[i-1:i+2]
            cc.y += slf.y[i-1:i+2]
            cc.z += slf.z[i-1:i+2]
            cc.atoms += slf.atoms[i-1:i+2]

      return cc

   def proton_coulomb(self,proton_index):
      xp = self.x[proton_index]
      yp = self.y[proton_index]
      zp = self.z[proton_index]

      U=0

      for i in range(len(self)):
         if i==proton_index:
            continue
         B = 0.52918 #  Angstr -> Bohr
         dx = (self.x[i] - xp)/B
         dy = (self.y[i] - yp)/B
         dz = (self.z[i] - zp)/B
   
         r = sqrt( dx*dx + dy*dy + dz*dz)

         if self.atoms[i] == 'O':
            ch = -0.8476
         else:
            ch = 0.4238
         U += ch/r
      return U*27.211385   # Hartree -> eV


class LMP:
   
   def __init__(self,exe_file,nn = 'NN-Water',sim_file = 'sim.templ', out_file='td.out', log_file='lmp.log',err_file='/dev/stderr'):
      self.exe_file = exe_file
      self.sim_file = sim_file
      self.log_file = log_file
      self.out_file = out_file
      self.err_file = err_file
      self.nn = nn

   def run(self,xyz,box_or_buffer=20,atomnames='H,O'):
      xyz.write('tmp.xyz');
      os.system('./xyz2lmp tmp.xyz ' + atomnames + ' '+ str(box_or_buffer) + ' > tmp.lmpsys');
      os.system('rm -f '+self.out_file);
      os.system('./make_sed_change input_data=tmp.lmpsys runner_dir='+self.nn+' td_file=' + self.out_file +' > sed.cmd')
      os.system('cat '+self.sim_file+' | sed -f sed.cmd > tmp.lmp')
      os.system( self.exe_file + '< tmp.lmp >' +self.log_file +' 2>'+self.err_file)
      
      #os.system(' cat ' +self.out_file+' | grep -v "#" | grep ^0 | gawk \'{print $5}\' > e.tmp ')
      os.system(' cat ' + self.log_file + ' | grep TotEng -A1 | tail -n1 | gawk \'{print $3 }\' > e.tmp')

      os.system(' cat ' + self.log_file + ' | grep TotEng -A1 | tail -n1 | gawk \'{print $5 }\' > etot.tmp')


      f=open('e.tmp')
      try:
         self.e = float( f.readline() );
      except:
         self.e = float('nan');
         print "NAN!"
      f.close()

      f = open('etot.tmp');
      try:
         self.etot = float( f.readline());
      except:
         self.etot = float('nan');
         print "NAN!"
      f.close();

      return self.e


def test_lmpdriver():
   a = XYZ()
   a.read('a.xyz')
   b = a.select_oxygens([1,4,7])
   l = LMP('../../src/lmp_debug')
   l.run(b)
   print l.e

def test_cluster_insert():
   a=XYZ()
   a.read('oktamer_proton.xyz')
   w = XYZ()
   w.read('water.xyz')
   wa = w.insert_cluster(a,2)
   pi=wa.proton_index()
   b=wa.nearliest_neighb(pi,8)
   a.show()
   raw_input('press enter')
   b.show()
  


