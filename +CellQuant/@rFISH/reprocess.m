function reprocess(rfish,funcs)

functions=struct('filter','probefilter','label','probelabel','measure','measureprobe','objects','filterobjects',...
    'relabel','relabel');

if ~isempty(funcs)&&iscell(funcs)
    for i=1:length(funcs)
        try
            rfish.(functions.(funcs{i}));
        catch
            display('Invalid function');
            fieldnames(functions)
        end
    end
else
    display('Usage: rfish.reprocess{func1,func2...}');
    display('Valid functions: ');
    fieldnames(functions)
    
end
    