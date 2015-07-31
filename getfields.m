function V=getfields(Cell,fld)
%
% Get (numeric) field fld from all the strucutres in the Cell
%
%  Works Also for 1D arrays! 
%

[M,N]=size(Cell);
V = cell(M,N);
L = zeros(M,N);

for i=1:M
    for j=1:N
        
        V{i,j} = Cell{i,j}.(fld);
        L=length(V{i,j});
    end
end

V = cell_get_values(V);

return;

if max(max(L)) == min(min(L))

    L = L(1,1);

    if L==1

        V1 = zeros(M,N);

        for i=1:M
            for j=1:N

                V1(i,j)=V{i,j};

            end
        end

        V=V1;
        return;

    end


    if N==1 
        V = V';
        [M,N]=size(V);
    end

    if M==1

        V1 = zeros(L,N);

        for i=1:N
     %       L
      %      size(V(:,i))
       %     size(V{i})
            V1(:,i) = V{i}(:);
        end


        V = V1;
        if L==1 
            V = V';
        end
    end

end

