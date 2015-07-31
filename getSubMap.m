function values=getSubMap(Map,keys)

L = length(keys);

values = NaN*ones(L,1);



for i=1:L
    
    key = cell2mat(keys(i));
    
    if Map.isKey(key)
        values(i) = Map(key);
    end
     
    
end