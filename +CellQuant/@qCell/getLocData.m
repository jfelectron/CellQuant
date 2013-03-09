function locmeasure=getLocData(qcell,channel,varargin)
 

    if ~isempty(qcell.locdata{channel})
        mtypes=fieldnames(qcell.locdata{channel});
    else
        display(sprintf('Channel %i contains no meausrements',channel))
        locmeasure=[];
        return
    end
        
 
    if ~isempty(varargin)
    
        meas=varargin{1};
   
            if ismember(meas,mtypes)
                locmeasure{i}=qcell.locadata{channel}.(meas);
            
                display(sprintf('%s not a measurement type in channel %i',meas,channel))
                qcell.getMeasureTypes(channel);
                locmeasure=[];
                return
            end
  
    else
        locmeasure=qcell.locdata{channel};

    end