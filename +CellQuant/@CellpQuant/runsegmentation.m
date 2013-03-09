function currentfield=runsegmentation(cellpop,imfile,silent)

%Create Image object, parse metadata, split channels


ims=CellQuant.Image(imfile,cellpop.savedir,cellpop.imdir);



currentfield=CellQuant.segCells(ims,cellpop.segchannel,cellpop.seedchannel,silent,cellpop.segprops);
currentfield.segmentCells();

cellhandles=currentfield.getCells();
for i=1:numel(cellhandles)
    qcell=cellhandles{i};
    qcell.setChannelIDs(cellpop.Chtypes);
end
    
