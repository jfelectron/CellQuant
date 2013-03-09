function loadField(cellpop,fieldname)

if isunix||ismac
        cd ([cellpop.imdir,'/','processed'])
    else
       cd ([cellpop.imdir,'\','processed'])
end

cellpop.currentfield=get(cellpop.fieldhash,fieldname);

if ~isempty(cellpop.currentfield)
    load([fieldname,'.field']);
else
    display('Error: Field not found')
    return
end

cellhandles=cellpop.currentfeld.getCells();

for i=1:numel(cellhandles)
    load([fieldname,'_',i,'.cell']);
end

