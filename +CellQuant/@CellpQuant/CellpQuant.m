classdef CellpQuant<handle
    properties (SetAccess=public)
        training=0;
        
    end
    properties (SetAccess=protected,GetAccess=protected,Hidden=true)
        ID=[];
      
        %cellhash=hashtable();%hash of cell object files keyed by cellnumber
        cellpdata=[];%array of pmeasuretype measurements for each cell 
        fieldhash=hashtable(); %hash of fieldnames
        %cellqdatahash=hashtable(); %hash of dip_measurement objects for each cell
        fishpdata=[];
        filenames=[];
        burstpdata=[];
        nTraining=300;
        trainingData=struct('params',[],'labels',[]);
        classifier=[];
        cellhash=hashtable();
        currentfield=[];
        segprops=struct('DOME_HEIGHT',20,'GAUSS_SIGMA',100,'MED_SHAPE','rectangular','MED_SIZE',10,...
         'MIN_SEED_SIZE',30,'MIN_CELL_SIZE',1000,'DT_THRESH',0.6,'CIRC_THRESH',1.35,'DIL_ITER',4,'DIL_SE',-1,'SEED_THRESH',50,'LMASK_THRESH',0.55,'MASK_THRESH',0.68);
       fishprops=struct('TH_SHAPE','elliptic','TH_TYPE','texture','TH_COLOR','white','TH_SIZE',7,'PROBE_THRESH',0.5,...
                    'BURST_THRESH',0.9,'CONN',2,'GRAD_SIGMA',0.9,'LABEL_MIN',40,'LABEL_MAX',300,'P2A_MAX',1.02,...
                    'SA_MIN',85,'P2A_MIN',0.96,'P2A_ABSMAX',1.15,'SD_THRESH',1,'GREY_SDMAX',1.3,'BURST_MINSD',25);
        savedir=[];
        nfields=0;
        nreseg=0;
        ncells=0;
        imfile=[];
        imdir=[];
        Chtypes=[];
        segID='GFP';
        seedID='DAPI';
        segchannel=[];
        seedchannel=[];
        resegment=hashtable();
        type=[];
        imext='.ics';
        ptypes={'segment','quantitate','all'}
        pmeasuretypes={'CellSize','Intensity','Transcripts'};
    end
    methods
        function cellpop=CellpQuant(varargin)
       
            switch nargin
                case 1
                type=varargin{1};
                    if isa(type,'char')
                        switch type
                            case 'single'
                                cellpop.type='single';
                            [cellpop.imfile,cellpop.imdir]=uigetfile('*.*','Select Image Stack to Process');
                              if isunix||ismac
                                    basedir='./';
                                else
                                    basedir='.\';
                              end
                            cellpop.savedir=uigetdir(basedir,'Select Directory to Save Output');
                            case 'batch'
                                if isunix||ismac
                                    basedir='./';
                                else
                                    basedir='.\';
                                end
                                cellpop.type='batch';
                                cellpop.imdir=uigetdir(basedir,'Select Image Directory');
                                cellpop.savedir=uigetdir(basedir,'Select Directory to Save Output');
                        end

                    chtypes=input('Please input channel types as a string (e.g. ''FISH GFP DAPI'' :  ');
                    cellpop.setChannels(chtypes);
                    cellpop.segchannel=find(ismember(cellpop.Chtypes,cellpop.segID)==1);
                    cellpop.seedchannel=find(ismember(cellpop.Chtypes,cellpop.seedID)==1);
                    elseif isa(type,'CellQuant.CellpQuant')
                          cellpop.ID=type.ID;
                          cellpop.filenames=type.filenames;
                          cellpop.savedir=type.savedir;
                          cellpop.imdir=type.imdir;
                          cellpop.segchannel=type.segchannel;
                          cellpop.seedchannel=type.seedchannel;
      
                          
                            
                    
                  
                    else
                        display('Error:')
                        display('Usage: CellpQuant(''run type'')')
                        display('CellpQuant(''run type'',{''image dir'',''savedir'',''image file (for single mode)''},''channel descriptors''');
                    end
                case 3
                    if isa(varargin{1},'char') && isa(varargin{2},'cell') && isa(varargin{3},'char')
                        cellpop.type=varargin{1};
                        file=varargin{2};
                        if strcmp(cellpop.type,'single')
                            cellpop.imdir=file{1};
                            cellpop.savedir=file{2};
                            cellpop.imfile=file{3};
                        else
                            cellpop.imdir=file{1};
                            cellpop.savedir=file{2};
                        end
                        cellpop.setChannels(varargin{3});
                    cellpop.segchannel=find(ismember(cellpop.Chtypes,cellpop.segID)==1);
                    cellpop.seedchannel=find(ismember(cellpop.Chtypes,cellpop.seedID)==1);
                    else
                       display('CellpQuant(''run type'',{''image dir'',''save dir''},''channel descriptors''')
                    end
                    
            end
   
      

        end
                    
                
              
                
           
        
        process(cellpop,varargin) 
        
        loadCelldata(cellpop);
        saveSingle(cellpop,dirname,flag)
        requant(cellpop)
        setProps(cellpop,type,props);
        props=getProps(cellpop,type);
        cellname=getCellID(cellpop,cellid);
        addTrainingData(cellpop,params,labels);
        saveMeasure(cellpop,varargin); %NI 
        hist(cellpop,type,measuretype); %NI
        scatter(cellpop,types,measuretype); %NI
        mu=mean(cellpop,type,measuretype); %NI
        sigmasq=var(cellpop,type,measuretype); %NI
        popstats=getMeasure(cellpop,type); 
        removeBursts(cellpop,channel,burstid)
        mansegment(cellpop,type);
    end
    methods (Access=protected)
        addFISHdata(cellpop,FISHdata,locdata,cellid)
        addBurstdata(cellpop,Burstdata,cellid)
        TCquant(cellpop)
        setChannels(cellpop,chtypes) 
        clearData(cellpop)
        getsavedFields(cellpop)
        addField(cellpop,imfile)
        saveField(cellpop,currentfield,imfile)
        currentfield=runsegmentation(cellpop,imfile,silent) 
        currentfield=runquantiation(cellpop,currentfield);
        currentfield=runtraining(cellpop,currentfield)

    end
end
    
