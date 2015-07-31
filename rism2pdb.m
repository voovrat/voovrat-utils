function rism2pdb(matfile,pdbfile,dist_unit,varargin)

sigma_eps = 0.01;
epsilon_eps = 1e-5;
charge_eps = 0.01;

if length(varargin)==1
    varargin=varargin{1}
end

if ~isempty(varargin) && strcmp(varargin{1},'AtomTypes')
  AT =1;
else    
  AT=0 ; 
argc=length(varargin);
atm_types = [];

for argn = 1:4:argc
    atm_types = [atm_types; struct('name',varargin{argn},...
                            'sigma',varargin{argn+1},...
                            'epsilon',varargin{argn+2},...
                            'charge',varargin{argn+3}) ]; 
    
    
    
end

end

load(matfile)

if ~ismember('System',who)
    System= load(matfile);
    %return
end

[DU,EU]=unit_names;



S = System;
S(:,1:4) = System(:,1:4) * unit2unit(DU,dist_unit,'Angstr');

f=fopen(pdbfile,'w');

L = size(System,1);

for i=1:L

    if ~AT
    
    AtmName = 'NA';
    for atm = atm_types'
        if ~isnan(atm.sigma) && abs(atm.sigma-System(i,4))>sigma_eps
            continue
        end
         if ~isnan(atm.epsilon) && abs(atm.epsilon-System(i,5))>epsilon_eps
            continue
         end       
          if ~isnan(atm.charge) && abs(atm.charge~=System(i,6))>charge_eps
            continue
          end          
         
         AtmName = atm.name;
    end
    
    else
        AtmName = varargin{2}{i};
    end
    
    fprintf(f,'%6s','ATOM  ');  %  1 -  6        Record name     "ATOM  "                                            A (1)          String   (6)                                          
    fprintf(f,'%5.0f',i);       %  7 - 11        Integer         serial        Atom serial number.                   B (2)          Integer  (5)
    fprintf(f,' ');             % 12                                                                                                                                                                                                                                                C (3)           not used  (1)
    fprintf(f,'%4s',AtmName);    % 13 - 16        Atom            name          Atom name.                           D (4)          String (4, left justified)
    fprintf(f,' ');             % 17             Character       altLoc        Alternate location indicator.        E (5)          String (1)
    fprintf(f,'%3s','   ');     % 18 - 20        Residue name    resName       Residue name.                        F (6)          String (3, left justified)
    fprintf(f,' ');             % 21                                                                                G (7)          not used  (1)
    fprintf(f,'%1s','A');       % 22             Character       chainID       Chain identifier.                    H (8)          String (1)
    fprintf(f,'%4.0f',i);       % 23 - 26        Integer         resSeq        Residue sequence number.             I (9)          Integer  (4)
    fprintf(f,'%1s',' ');       % 27             AChar           iCode         Code for insertion of residues.      J (10)         String (1)
    fprintf(f,'%3s','   ');     % 28 - 30                                                                           K (11)         not used (3)
    fprintf(f,'%8.3f',S(i,1));  % 31 - 38        Real(8.3)       x             Orthogonal coordinates for X in      L (12)         Real (8, XXXX.XXX)
                                %                                              Angstroms.
    fprintf(f,'%8.3f',S(i,2));  % 39 - 46        Real(8.3)       y             Orthogonal coordinates for Y in      M (13)         Real (8, XXXX.XXX)
                                %                                              Angstroms.
    fprintf(f,'%8.3f',S(i,3));  % 47 - 54        Real(8.3)       z             Orthogonal coordinates for Z in      N (14)         Real (8, XXXX.XXX)
                                %                                              Angstroms.
    fprintf(f,'%6.2f',1);       % 55 - 60        Real(6.2)       occupancy     Occupancy.                           O (15)         Real (6, XXX.XX)
    fprintf(f,'%6.2f',1);       % 61 - 66        Real(6.2)       tempFactor    Temperature factor.                  P (16)         Real (6, XXX.XX)
    fprintf(f,'%6s','      ');  % 67 - 72                                                                           Q (17)         not used (6)
    fprintf(f,'%4s','A1  ');    % 73 - 76        LString(4)      segID         Segment identifier, left-justified.  R (18)         String (4, left justified)
    fprintf(f,'%2s',AtmName);      % 77 - 78        LString(2)      element       Element symbol, right-justified.     S (19)         String (2, right justified)
    fprintf(f,'%1.0f',round( abs(System(i,6)) ) );% 79 - 80        LString(2)      charge        Charge on the atom.                  T (20)         
    if System(i,6)>0
        fprintf(f,'+');
    else
        fprintf(f,'-');
    end
    fprintf(f,'\n');


end

fclose(f);
