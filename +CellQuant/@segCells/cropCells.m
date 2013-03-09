function cropCells(cells)

cells.cropdata=measure(cells.segimages.celllabels,cells.segimages.midsection,cells.cellmeasures);
celldata=cells.cropdata;
%nslice=cells.Metadata.dimensions(4);
nslice=cells.Metadata.dimensions(3);
nCh=cells.Metadata.NCh;
for i=1:length(celldata)
    bb=[celldata(i).Minimum,celldata(i).Maximum]; %get bounding box
    chcropped=newimar(nCh);
    celllabel=cells.segimages.celllabels(bb(1,1):bb(1,2),bb(2,1):bb(2,2));
    cellskel=cells.segimages.cellskeleton(bb(1,1):bb(1,2),bb(2,1):bb(2,2));
    cellmask=celllabel>0;   
    cellmask(celllabel~=i)=0;
    cellmask=fillholes(cellmask);
    cellskel(cellmask==0)=0;%mask pixels outside of current object
    cellmask=repmat(cellmask,[1 1 nslice]);
    cellskel=repmat(cellskel,[1 1 nslice]);
    for j=1:nCh
        ch=cells.field.getChannels(j);
        chcropped{j}=ch(bb(1,1):bb(1,2),bb(2,1):bb(2,2),:)*cellmask;
    end
    clear cells.field
    cells.cellhandles{i}=CellQuant.qCell(chcropped,cellskel,cellmask,cells.segchannel,cells.cropdata(i));
end

cells.ncells=numel(cells.cellhandles);
    

