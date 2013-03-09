function field=getField(cellpop,varargin)



if isempty(varargin) && ~isempty(cellpop.currentfield)
    field=cellpop.currentfield;
elseif isa(varargin{1},'double')
    fieldfile=get(cellpop.fieldhash,varargin{1});
    load -mat fieldfile
    
        
else
    display('Please indicate desired field number');
end
    
        
    

