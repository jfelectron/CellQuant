function cellmeasure=getCellData(qcell,channel,varargin)
 

    if ~isempty(qcell.celldata{channel})
        mtypes=fieldnames(qcell.celldata{channel});
    else
          %display(sprintf('channel %i contains no meausrements',channel))
        cellmeasure=[];
        return
    end
        
 
    if ~isempty(varargin)
    
        measuretypes=varargin{1};
   
        nummeas=numel(measuretypes);
        nobjs=numel(qcell.celldata{channel}.id);
        cellmeasure=cell(nummeas);
        cellmeasurements=cell(nobjs,nummeas);
        for i=1:nummeas
            meas=measuretypes{i};
            if ismember(meas,mtypes)
                cellmeasure{i}=qcell.celldata{channel}.(meas);
                for j=1:nobjs
                    cellmeasurements(j,i)={cellmeasure{i}(j)};
                end
            else
                display(sprintf('%s not a measurement type in channel %i',meas,channel))
                qcell.getMeasureTypes(channel);
                cellmeasure=[];
                return
            end
        end

        cellmeasure=dip_measurement(cell2struct(cellmeasurements,measuretypes,2));
    
    else
        cellmeasure=qcell.celldata{channel};

    end

