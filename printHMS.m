function printHMS(Seconds)
%
%  Volodymyr P Sergiievskyi, voov.rat@gmail.com
%
%  printHMS(Seconds)
%
%  Print the time in seconds in the HMS (hour-minute-second) format.
%
%  Seconds can also be a matrix
%


[m,n]=size(Seconds);

for i=1:m
    for j=1:n
   
        H = floor(Seconds(i,j)/3600);
        M = floor((Seconds(i,j) - 3600*H)/60);
        S = mod(round(Seconds(i,j)),60);
        
        if H>0
            fprintf('%2dh ',H);
        else
            fprintf('   ');
        end
        if M>0 || H>0
            fprintf('%2dm ',M);
        else
            fprintf('   ');
        end
        
        fprintf('%2ds\t',S);
            
        
    end
    fprintf('\n');
end