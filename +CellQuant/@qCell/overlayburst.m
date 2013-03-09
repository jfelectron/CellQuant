function varargout=overlayburst(qcell,greych,burstch)
%%Usage: qcell.overlaylabel(greych,labelch)
%%overlays desired qcell label channel (labelch) with grey channel (greych)
try
    if isa(greych,'double') && isa(burstch,'double')
        chid=qcell.channelIDs;
        if strcmp(qcell.channelIDs{greych},'FISH')
            greyim=qcell.processed{greych};
        else
            greyim=qcell.raw{greych};
            if strcmp(qcell.channelIDs{greych},'DAPI')
                greyim=0.5*stretch(greyim);
            end
        end
        labelim=qcell.bursts{burstch};
        if ~isempty(labelim)
            overlayout=overlay(greyim,labelim);
        else
            overlayout=[];
        end
        if ~nargout
            
            h=dipshow(overlayout);
            diptruesize(h, 50);
            varargout=[];
            return;
        end
        varargout={overlayout};
        
        
    end
    
catch ME
    ME
    varargout=[];
    return;
end


