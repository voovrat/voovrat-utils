function spigel(file,output,direction)

[A0,map,alpha0] = imread(file);

A1 = double(A0);

Mx = max(max(max(A1)));

if Mx<2
   A = A1;
   alpha = double(alpha0);
else
   A = A1/255;
   alpha = double(alpha0)/255;
end


if nargin<3 || direction == 'a'
   [m,n,k]=size(A);
   if m>n
       direction = 'h';
   else
       direction = 'v';
   end
end


if direction=='h' || direction=='H'
   B = [ A A(:,end:-1:1,:)];
   balp = [ alpha alpha(:,end:-1:1)];
end

if direction=='v' || direction =='V';
   B = [A;A(end:-1:1,:,:)];
   balp = [alpha; alpha(end:-1:1,:)];
end
size(balp)
imwrite(B,output,'Alpha',balp)
