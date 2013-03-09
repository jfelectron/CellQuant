function addBurstdata(cellpop, Burstdata,cellid)

numobjs=size(cellpop.burstpdata,1);

singleid=dip_measurement('Cell_ID',cellid);
 numnew=size(Burstdata,1);
 if numnew~=0
    for i=Burstdata.ID
        singleid.ID=i;
        if ~exist('cellids','var')
            cellids=singleid;
        else
            cellids=[cellids;singleid];
        end
    end
    Burstdata=[Burstdata,cellids];
    if numnew>1
        Burstdata.ID=(numobjs+1):(numobjs+numnew);
   else
       Burstdata.ID=numobjs+1;
   end
if ~numobjs
    cellpop.burstpdata=Burstdata;
    return
else
   
        cellpop.burstpdata=[cellpop.burstpdata;Burstdata];
 end
 end
