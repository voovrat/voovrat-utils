function B=rgb2gray(A)
%
% B=rgb2gray(A)
% 
%  A - rgbimage, MxNx3
%

if length(size(A))==2
	B=A;
	return
end 

B=0.299*A(:,:,1) + 0.5876*A(:,:,2) + 0.114*A(:,:,3);


