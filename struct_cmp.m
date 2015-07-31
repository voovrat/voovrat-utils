function report=struct_cmp(A,B)

report = {};


FA = fieldnames(A);
FB = fieldnames(B);

if (length(FA) != length(FB))

    report = [report; {'Structures has different number of fields'} ];

end

F = intersect(FA,FB);
N=length(F);

for i=1:N

    fld = F{i};

    if isstruct(A.(fld)) 

        if isstruct(B.(fld))

            subreport = struct_cmp(A.(fld),B.(fld));

            if length(subreport)>0
                   report = [ report; { [ 'subfield ' fld ':' ]}; subreport ];
            end

        else
            report = [report; { [ 'Field ' fld ' has different type in structures' ] }];
        end

        continue

    end

    if iscell(A.(fld))

        if iscell(B.(fld))

            subreport = cell_cmp(A.(fld),B.(fld));

            if length(subreport)>0
                   report = [ report; { [ 'subfield ' fld ':' ]}; subreport ];
            end

        else
            report = [report; { [ 'Field ' fld ' has different type in structures' ] }];
        end

        continue

    end

    if sum( size(A.(fld)) ~= size(B.(fld)) )>0

        report  = [ report; { [ 'Fields ' fld ' has different length' ] }];

        continue;

    end


    if sum(A.(fld) ~= B.(fld) )>0

        report = [ report; {['Fields ' fld ' are different ']}];

    end

end
