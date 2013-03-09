function setChannelIDs(qcell,ChIDs)
    if isa(ChIDs,'cell')
          qcell.channelIDs=ChIDs;
    else
        display('Usage: qCell.setChannelIDs({ChID1, ChID2,}');
    end
          
          