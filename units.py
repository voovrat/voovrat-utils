
# [DistanceUnits, EnergyUnits, ChargeUnits,Const,MassUnits ]  = unit_names
# return Maps from unit to SI (meter, Joule)
# Usage:
#   [DU,EU]=unit_names
#   unit2unit(EU,'J','K')
def unit_names():
  
  kB=1.3806504e-23; # J/K
  Na=6.02214179e23; # 1/mol
  Tn = 298.15; # K, normal temperature
  hbar = 1.05457172647e-34; # J*s planck costant
  
  DistanceUnits = { 'm':1,  
  'cm':1e-2, 
  'Angstr':1e-10, 
  'Bohr':5.291772108e-11, 
  'sigma_water':3.1556e-10,  
  'nm':1e-9};
  
  EnergyUnits = {  'J':1, 
  'Hartree': 4.35974417e-18, 
  'kcal/mol': 6.9477e-21, 
  'KBT':Tn*kB, 
  'kJ/mol': 1000/Na, 
  'eV':1.60217653e-19, 
  'K': kB};
  
  ChargeUnits = { 'C':1, 
      'e':1.60217648740e-19 }
  
  Const= {  
  'kB':kB, 
  'Na':Na, 
  'hbar':hbar}
  
  MassUnits={  
  'kg':1, 
  'Da':1.66053892173e-27}

  Units = { 'DU' : DistanceUnits, 
            'DistanceUnits': DistanceUnits,
            'EU' : EnergyUnits,
            'EnergyUnits': EnergyUnits,
            'MU' : MassUnits,
            'MassUnits' : MassUnits,
            'Const' : Const,
            'CU' : ChargeUnits,
            'ChargeUnits' : ChargeUnits}

  return Units

#  
def unit2unit(unit1,unit2,Tab = None): 
 
  if Tab == None:
    U = unit_names()
    for tabname in U.keys():
      Tab = U[tabname]
      if unit1 in Tab:
         break

  if not (unit1 in Tab) or not (unit2 in Tab): 
    raise (BaseException('One of the units is unknown (or incompatible): ' + unit1 + ' or ' + unit2))

  V1 = Tab[unit1]
  V2 = Tab[unit2]
  
  return  V1/V2;

  
