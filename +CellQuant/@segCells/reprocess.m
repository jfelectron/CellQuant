function reprocess(cells,funcs)

functions=struct('preprocess','preprocess','reconstruction','reconstruct','seeds','cellseeds','mask','maskcells',...
    'segment','growregions','crop','cropCells');

if ~isempty(funcs)&&iscell(funcs)
    for i=1:length(funcs)
        try
            cells.(functions.(funcs{i}));
        catch ME
            display('Invalid function');
            fieldnames(functions)
        end
    end
else
    display('Usage: cells.reprocess{func1,func2...}');
    display('Valid functions: ');
    fieldnames(functions)
    
end
    
    
   
