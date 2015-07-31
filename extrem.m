function [xmax,ymax,xmin,ymin]=extrem(f)

N=size(f,1);

xmax=[];
ymax=[];
xmin=[];
ymin=[];

for i=2:N-1
   
    if f(i)>f(i+1) && f(i)>f(i-1)
        xmax=[xmax;i];
        ymax=[ymax;f(i)];
    end
    
    if f(i)<f(i+1) && f(i)<f(i-1)
        xmin=[xmin;i];
        ymin=[ymin;f(i)];
    end  
    
end