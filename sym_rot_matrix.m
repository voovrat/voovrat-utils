function rot=sym_rot_matrix(i,j,angle,phase_inverse)
%
%  rot=sym_rot_matrix(i,j,angle,phase_inverse=0)
%

if nargin<4
   phase_inverse=0;
end

rot = {'1','0','0'
       '0','1','0'
       '0','0','1'}; 

if phase_inverse

    SIN = 'cos';
    COS = 'sin';

else

    SIN = 'sin';
    COS = 'cos';

end


rot(i,i) = [ COS  angle ];
rot(j,j) = [ COS angle ];

rot(i,j) = [ SIN angle ];
rot(j,i) = [ '-' SIN angle ];



