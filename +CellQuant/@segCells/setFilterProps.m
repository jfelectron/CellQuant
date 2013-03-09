function setFilterProps(cells,props)

    if ~iscell(props);
        properror();
        return;
    else
        for i=1:2:length(props)-1
            propname=cell2mat(props(i));
            propval=cell2mat(props(i+1));
            if ~isempty(propname(i)) && ~isempty(propval)
                cells.filterprops.(propname)=propval;
            else
                properror();
                return;
            end
        end
    end
end
                
                
 function properror()
        display('setFilterProps(props)');
        display('props should be cell array of form')
        display('{property,value}') 
 end
            
            