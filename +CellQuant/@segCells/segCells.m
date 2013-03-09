classdef segCells<handle
    
    properties (SetAccess=protected,GetAccess=protected,Hidden=true)
        filterprops=struct('DOME_HEIGHT',20,'GAUSS_SIGMA',100,'MED_SHAPE','elliptic','MED_SIZE',30,...
            'MIN_SEED_SIZE',1500,'DT_THRESH',0.6,'CIRC_THRESH',1.5,'DIL_ITER',4,'DIL_SE',-1,'SEED_THRESH',2.5,'MASK_THRESH',0.8);
        segimages=struct('midsection',[],'seedsection',[],'preprocess',[],'rec',[],'dt',[],'dt_binary',[],'gfpseeds',[],'nuc_binary',[],'nucseeds',[],'cellseeds',[],'cellmask',[],...
            'celllabels',[],'cellskeleton',[],'seed_overlay',[],'label_overlay',[],'skeleton_overlay',[]);
        labelimages={'celllabels' 'cellseeds'};
        saveimages={'midsection','preprocess','dt','rec','seed_overlay','label_overlay','skeleton_overlay'};
        cellmeasures={'Minimum','Maximum','Size','Center','P2A','PodczeckShapes','Feret'};
        cropdata=[];
        imext='.ics';
        segchannel=[];
        seedchannel=[];
        field=[];
        segmented=0;
        quantitated=0;
        saved=0;
        ncells=[];
        checkseg=0;
        requant=0;
        silent=[];
        Metadata=[]'
        cellhandles={};
    end
    
    methods (Access=public)
        function cells=segCells(varargin) %constructor
           
            if nargin==1
                    return
            elseif nargin>=4
                    if isa(varargin{1},'CellQuant.Image') && isa(varargin{2},'double')  && isa(varargin{3},'double') && isa(varargin{4},'double')
                       cells.segchannel=varargin{2};
                       cells.seedchannel=varargin{3};
                       cells.loadfstack(varargin{1});
                       cells.silent=varargin{4};
                       if nargin==5
                           cells.filterprops=varargin{5};
                       end
                    else
                       display('Error:  CellQuant.SegCells() requires CellQuant.Image object and segmentation channel');
                       return; 
                    end
            end
        end
                    
        display(cells)
        setFilterProps(cells,props)
        loadfstack(cells,istack)
        metadata=getMetaData(cells)
        saveimages=getSaveImages(cells)
        filterprops=getFilterProps(cells,varargin)
        segmentCells(cells,varargin)
        seedimages=getSeeds(cells)
        varargout=getImage(cells,imtypes);
        cellhandles=getCells(cells,varargin)
        flag=issegmented(cells)
        flag=isquantitated(cells)
        flag=issaved(cells)
        flag=status(cells,type)
        delete(cells)
        reprocess(cells,funcs); %Test level access to invidual steps, remove when done testing
        
    end

    methods (Access=protected,Hidden=true)
        preprocess(cells)
        reconstruct(cells)
        maskcells(cells)
        cellseeds(cells)
        flag=growregions(cells,manual,display)
        [lcells,flag]=resegment(cells,lcells,manual,display)
        lcells=cellcheck(cells,lcells)
        cropCells(cells)
        %celllsave=saveobj(cells)
    end
end
        
        
        
        
        
        
        
        
        