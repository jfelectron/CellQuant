function varargout=overlaylabel(qcell,greych,labelch)
%%Usage: qcell.overlaylabel(greych,labelch)
%%overlays desired qcell label channel (labelch) with grey channel (greych)
try
    if isa(greych,'double') && isa(labelch,'double')
        if ~strcmp(qcell.channelIDs{greych},'GFP')
            greyim=qcell.processed{greych};
        else
            greyim=qcell.raw{greych};
        end
        labelim=qcell.labels{labelch};
        if min(size(greyim)==size(labelim))
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




