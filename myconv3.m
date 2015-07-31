function C=myconv3(A,B)
%
% Just to remeber the correct operations
% 

FA=fftn(fftshift(A));
FB=fftn(fftshift(B));

C=real(fftshift(ifftn(FA.*FB)));
