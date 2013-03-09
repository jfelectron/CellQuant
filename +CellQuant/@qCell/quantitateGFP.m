 function quantitateGFP(qcell,channel)


GFPdata=qcell.celldata{channel};
%cellintensity=measure(qcell.masks{channel},qcell.raw{channel},{'Sum'});
celldata=measure(label(fillholes(qcell.raw{channel}>median(qcell.raw{channel})),2,75000,0),qcell.raw{channel},{'Sum','Size','Center'});
if size(celldata,1)>1
    l=find(max(celldata.Size));
    celldata=celldata(l);
end

mferet=mean([GFPdata.feret(1),GFPdata.feret(2)]);
try 
    qcell.celldata{channel}=dip_measurement('CellSize',celldata.Size,'CellMidSize',GFPdata.size,'Centroid',celldata.Center,'Mean_Feret',mferet,'Intensity',celldata.Sum,'Circularity',GFPdata.p2a);
catch ME
    ME
    return;
end

qcell.quantitated(channel)=1;





