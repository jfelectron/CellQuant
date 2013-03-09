function currentfield=runtraining(cellpop,currentfield)




%update this with additional channels as needed
fishchannels=find(ismember(cellpop.Chtypes,'FISH')==1);

cellhandles=currentfield.getCells();
for i=1:numel(cellhandles)
    celldata=cellhandles{i}.getCellData(gfpchannel);
    if isfield(celldata,'CellSize')||isfield(celldata,'Size')&&celldata.Size>1000
     cellhandles{i}.setFilterProps(cellpop.fishprops);
        cellhandles{i}.quantitateFISH(fishchannels);
       
    end
end



