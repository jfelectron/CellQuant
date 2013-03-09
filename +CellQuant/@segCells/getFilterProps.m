function filterprops=getFilterProps(cells,varargin)

if ~isempty(varargin)
    if iscell(props)
        numprops=length(props);
        propvals=cell(1,numprops);
        for i=1:numprops
            propvals(i)={cells.filterprops.(cell2mat(props(i)))};
        end
        filterprops=cell2struct(propvals,props,2);  
    else
        display('getFilterProps(props), where props is a cell array of desired properties');
    end
else
    filterprops=cells.filterprops;
end

    
        
        
    
    