function getChannelIDs(qcell)
    nch=numel(qcell.channelIDs);
    
    for i=1:nch
        display(sprintf('Ch %i : %s',i,qcell.channelIDs{i}));
    end