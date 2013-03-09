function quantitateFISH(qcell,channels)

    nch=numel(channels);
    probechannels=qcell.getImage(channels,{'raw'}); %retrieve raw probe channels from qcell object
   if isempty(qcell.filterprops)
        FISHquant=CellQuant.rFISH(probechannels);
   else
       FISHquant=CellQuant.rFISH(probechannels,qcell.filterprops);
   end %load probe channels into new rFISH object arra
   
   %FISHquant.training=qcell.training;
    
    for i=1:nch
        FISHquant(i).countFISH();
        qcell.processed{channels(i)}=FISHquant(i).getImage({'probe_filtered'});
        qcell.labels{channels(i)}=FISHquant(i).getImage({'relabeled_probe'});
        qcell.masks{channels(i)}=FISHquant(i).getImage({'binary_thresholded'});
        qcell.celldata{channels(i)}=FISHquant(i).getProbeData();
        qcell.qobjs{channels(i)}=FISHquant(i);
        qcell.burstdata{channels(i)}=FISHquant(i).getBurstData();
        qcell.bursts{channels(i)}=FISHquant(i).getImage({'burst_relabeled'});
    end
    clear FISHquant
    
    qcell.quantitated(channels)=1;
    
    
  
    
    
    
    

