function  setFilterProp(rfish,channel,varargin)

      if ~isempty(varargin)
          props=varargin{1};
          for i=1:2:numel(props)
              
            if ismember(prop,fieldnames(rfish.filterprops))
               rfish.pfilterprops.(propps(i))(channel)=props(i+1); 
            else
                display('These properties are available to change:')
                display(fieldnames(pfilterprops))
            end
      else
         display('These properties are available to change:')
         display(fieldnames(pfilterprops))
         display('Input cell array of property, value pairs')
          end