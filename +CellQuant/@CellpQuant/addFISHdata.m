function addFISHdata(cellpop, FISHdata,cellid)

numobjs=size(cellpop.fishpdata,1);

singleid=dip_measurement('Cell_ID',cellid);
 numnew=size(FISHdata,1);
 if numnew~=0
    for i=1:numnew
        singleid.ID=i;
        if ~exist('cellids','var')
            cellids=singleid;
        else
            cellids=[cellids;singleid];
        end
    end
    FISHdata=[FISHdata,cellids];
if ~numobjs
    cellpop.fishpdata=FISHdata;
    return
else
   
        FISHdata.ID=(numobjs+1):(numobjs+numnew);
        cellpop.fishpdata=[cellpop.fishpdata;FISHdata];
    end
 end
