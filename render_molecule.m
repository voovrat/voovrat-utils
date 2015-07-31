function render_molecule(xyz_filename,image_name,distance)

if nargin<3
   distance=10; % distance to the z-plane (to be added to z coordinates)
end

if ~exist('test.light')

   system('echo -6 0 -20 500 > test.light');

end


system([ 'tail -n+3 ' xyz_filename ' > mol.tmp ' ]);

f=fopen('mol.tmp');
C=textscan(f,'%s%f%f%f');
fclose(f);

names = C{1};
XYZ = [ C{2} C{3} C{4} ];

XYZ(:,3) = XYZ(:,3) + distance;

N =length(names);

IH = find( strcmp(names,'H'));
IC = find( strcmp(names,'C'));
IN = find( strcmp(names,'N'));
IO = find( strcmp(names,'O'));
IS = find( strcmp(names,'S'));

Colors = zeros(N,3);

Colors(IH,:) = ones(length(IH),1) * [1 1 1];
Colors(IC,:) = ones(length(IC),1) * [0.5 0.5 0.5];
Colors(IN,:) = ones(length(IN),1) * [0 0 1];
Colors(IO,:) = ones(length(IO),1) * [ 1 0 0];
Colors(IS,:) = ones(length(IS),1) * [ 1 1 0];

Radii = zeros(N,1);

Radii(IH) = 0.7;
Radii(IC) = 1;
Radii(IN) = 0.8;
Radii(IO) = 0.9;
Radii(IS) = 1.2;

%tricol = zeros(0,12);

system('rm -f mol.tricolor');

[SP0,col] = tri_sphere( 40, [1 1 1]);
Ntri = size(SP0,1);

for i=1:N

fprintf('%f of %f\n',i,N);

%[SP0,col] = tri_sphere( 40, Colors(i,:));
col = ones(Ntri,1) * Colors(i,:);

SP1 = tri_rotate(SP0,[0 0 0]);
SP2 = SP1 * Radii(i);
SP3 = tri_translate(SP2,XYZ(i,:));

SP_all = [SP3 col];

save -ascii tmp.tri SP_all 

system('illuminate2 tmp.tri test.light >> mol.tricolor');

end

system([ 'render3d --input=mol.tricolor --output=' image_name ]);

