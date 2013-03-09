function flags=isquantitated(qcell)

flags=qcell.quantitated;

if isempty(flags)
    flags=[0 0 0];
end

