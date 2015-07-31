function xyz2base(DataSetsPath,DataSet)

C = dir('*.coors');

for fname=C(1,:)
    %fname = sprintf('CUP080%02d',i);
    S=strread(fname.name,'%s',1,'delimiter','.');
    name=S{1};
    
    %system(['cat ' fname '.xyz | tail -n+3 | gawk ''{print $ 2" "$3" "$4}'' >' fname '.coors']);
    XYZ = load([fname '.coors']);
    %system(['./ff ' fname '.pdb | gawk ''{print $6" "$7" "$5}'' > ' fname '.opls' ]);
    OPLS = load([fname '.opls']);
    Sys = [XYZ OPLS];
    key=struct;
    key.DataSet = DataSet;
    key.type = 'System';
    key.Name = name;
    key.ForceField = 'OPLSAA';
    key.DistanceUnits = 'Angstr';
    key.EnergyUnits = 'kcal/mol';
    writeDataKey(DataSetsPath,key,'System',Sys);
    %eval(['save ' fname '.txt -ASCII -double Sys']);
end