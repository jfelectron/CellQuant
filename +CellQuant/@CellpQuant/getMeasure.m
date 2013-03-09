function popstats=getMeasure(cellpop,type)

if strcmp(type,'cells')
   
    popstats=cellpop.cellpdata;
elseif strcmp(type,'FISH')
    popstats=cellpop.fishpdata;
elseif strcmp(type,'Bursts')
    popstats=cellpop.burstpdata;
 end