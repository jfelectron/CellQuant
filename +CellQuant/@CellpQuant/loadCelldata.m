function loadCelldata(cellpop)
cellpop.cellpdata=[];
cellpop.fishpdata=[];
cellpop.burstpdata=[];
ncells=0;
    fields=dir([cellpop.savedir,'/','*R3D']);
    numfields=length(fields);
    
    if isempty(numfields)
        numfields=0;
    end
    for i=1:numfields;
        field=fields(i).name;
        fielddir=[cellpop.savedir,'/',field,'/'];
        cells=dir([fielddir,'*.mat']);
    for j=1:numel(cells)
        ncells=ncells+1;
        try
            load([fielddir,cells(j).name])
            flag=1;
        catch ME
            ME
            disp('File load error');
            flag=0;
        end
       
        if flag
        cellname=strtok(cells(j).name,'.mat');
        cellnumber=regexp(cellname,'R3D_','split');
        cellnumber=str2double(cellnumber{2});
        eval(sprintf('curcell=%s;',cellname));
        fishchannel=find(ismember(cellpop.Chtypes,'FISH')==1);
        gfpchannel=find(ismember(cellpop.Chtypes,'GFP')==1);
        FISHdata=curcell.getQuant(fishchannel);
        locdata=curcell.getLocData(fishchannel);
        ungated=length(FISHdata.probedata);
        gated=length(FISHdata.probedata_r);
        %if (gated>0)
        %    gatedA=find(FISHdata.probedata_r.P2A>0.98&FISHdata.probedata_r.P2A<1.01);
        %    gatedW=length(gatedA);
        %    gatedC=length(locdata.C_weighted)-length(setdiff(locdata.C_weighted,gatedA));
        %else 
        %    gatedW=0;
        %    gatedC=0;
        %end
        
%         
        Burstdata=curcell.getBurstData(fishchannel);
        %locdata=curcell.getLocData(fishchannel);
        numtranscripts=dip_measurement('Transcripts_raw',ungated,...
                'Transcripts',gated,'TNuc',length(locdata.N_weighted),'TCyt',length(locdata.C_weighted),...
                'TxCenter',size(Burstdata,1));
        celldata=curcell.getCellData(gfpchannel);
        try
        celldata=[celldata,numtranscripts];
        celldata.ID=ncells;
        cellpop.cellhash=put(cellpop.cellhash,ncells,cellname);
        cellpop.addFISHdata(FISHdata.probedata,celldata.ID); %adds FISH data to meta
            %population array
            cellpop.addBurstdata(Burstdata,celldata.ID);
          if isempty(cellpop.cellpdata) %initialize if adding for the first time
            cellpop.cellpdata=celldata;
          else
            
                cellpop.cellpdata=[cellpop.cellpdata;celldata];
           
          eval(sprintf('delete(%s)',cellname));
          eval(sprintf('clear %s',cellname));    
            end
          
       
         catch ME
              ncells=ncells-1;
        end
        end
      
    end
   clearvars -except cellpop i j fields numfields ncells
   end
%cellpop.TCquant();

    