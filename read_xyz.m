function [XYZ,atoms] = read_xyz(fname)

f=fopen(fname);

nlin = str2num(fgets(f));
fgets(f);

XYZ = zeros(nlin,3);
atoms=cell(nlin,1);

for i=1:nlin

  s = fgets(f);
  words=strsplit(strtrim(s));
  XYZ(i,:) = [ str2num(words{2}) str2num(words{3}) str2num(words{4}) ];
  atoms{i} = words{1};


end
