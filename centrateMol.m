function XYZ = centrateMol(XYZ0)

N = size(XYZ0,1);

Max = max(XYZ0);
Min = min(XYZ0);

XYZ = XYZ0 - ones(N,1) * (Max + Min)/2 ;

