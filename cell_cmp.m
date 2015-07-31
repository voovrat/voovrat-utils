function report=cell_cmp(A,B)

report = {};

if (length(A) != length(B))

    report = [report; {'Structures has different number of fields'} ];

end

N=min(length(A),length(B));

for i=1:N

  
    if isstruct(A{i}) 

        if isstruct(B{i})

            subreport = struct_cmp(A{i},B{i});

            if length(subreport)>0
                   report = [ report; { [ 'subfield ' fld ':' ]}; subreport ];
            end

        else
            report = [report; { [ 'Field ' fld ' has different type in structures' ] }];
        end

        continue

    end

    if iscell(A{i})

        if iscell(B{i})

            subreport = cell_cmp(A{i},B{i});

            if length(subreport)>0
                   report = [ report; { [ 'subfield ' fld ':' ]}; subreport ];
            end

        else
            report = [report; { [ 'Field ' fld ' has different type in structures' ] }];
        end

        continue

    end

    if sum( size(A{i}) ~= size(B{i}) )>0

        report  = [ report; {['Fields ' fld 'has different length']}];

        continue;

    end


    if sum(A{i} ~= B{i} )>0

        report = [ report; {['Fields ' fld 'are different ']}];

    end

end
