function measuretypes=getMeasureTypes(qcell,channel);

    display(sprintf('Measurementypes available for channel %i : ',channel))
    display(fieldnames(qcell.celldata{channel}));
    
    