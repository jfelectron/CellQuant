classdef qCell<handle
    properties (SetAccess=public)
        training=0;
    end
    properties (SetAccess=protected,GetAccess=private,Hidden=true)
        raw=[];%raw input stacks
        processed=[];
        labels=[];
        bursts=[];
        imtypes=struct('raw','raw','filtered','processed','labeled','labels','nuclearG','labeled_NG','cytoplasmG','labeled_CG','nuclearW','labeled_NW','cytoplasmW','labeled_CW','skeleton','cellskels','binary','masks','burst','bursts');
        channelIDs=[];; %binary masks
        celldata=[];
        labeled_NG=[];
        labeled_CG=[];
        labeled_NW=[];
        labeled_CW=[];
        locdata=[];
        cellskels=[]; %binary skeleton array
        masks=[]
        burstdata=[];
        quantitated=[];
        filterprops=[];
        qobjs=[]; %array of quantitation object for each channel
    end
    

   methods (Access=public)
       function qcell=qCell(varargin)
           if nargin==0
               return;
           
           elseif nargin>=5
                   if isa(varargin{1},'dip_image_array') && isa(varargin{2},'dip_image') && isa(varargin{3},'dip_image')...
                           && isa(varargin{4},'double') && isa(varargin{5},'dip_measurement')
                        segch=varargin{4};
                        qcell.raw=varargin{1};
                        nch=length(qcell.raw);
                        qcell.cellskels{segch}=varargin{2};
                        qcell.masks{segch}=varargin{3};
                        qcell.processed=newimar(nch);
                        qcell.labels=newimar(nch);
                        qcell.labeled_NG=newimar(nch);
                        qcell.labeled_CG=newimar(nch);
                        qcell.labeled_NW=newimar(nch);
                        qcell.labeled_CW=newimar(nch);
                        qcell.bursts=newimar(nch);
                        qcell.celldata=cell(nch,1); 
                        qcell.qobjs=cell(nch,1);
                        qcell.quantitated=zeros(1,nch);
                        qcell.celldata{segch}=varargin{5};
                        if nargin==6 && isa(varargin{6},'struct')
                            qcell.filterprops=varargin{6};
                        end
                   else
                       display('Usage: qCell(cell stack,cell mask stack,cell skeleton stack, segmentaion channel,cropdata)');
                   end
           else
               
              display('Usage: Cell(cell stack,mask stack)'); 
           end
       end     
       setChannelIDs(qcell,ChIDs); 
       varargout=getImage(qcell,varargin);
       getChannelIDs(qcell); 
       locmeasure=getLocData(qcell,channel,varargin)
       localization(qcell,nucchannel,fishchannels);
       flags=isquantitated(qcell);
       delete(qcell)
       quantitateFISH(qcell,channels);
       quantitatemCherry(qcell,nucchannel,channels);
       quantitateGFP(qcell,channels); 
       setFilterProps(qcell,props);
       varargout=overlaylabel(qcell,greych,labelch);
       varargout=overlayburst(qcell,greych,burstch);
       measuretypes=getMeasureTypes(qcell,channel); 
       quanthandle=getQuant(qcell,channels);
       cellmeasure=getCellData(qcell,channel,measuretypes); 
       burstmeasure=getBurstData(qcell,channel,measuretypes);
       removeBurst(qcell,channel,burstid);
   end

end
           
                   
                   
        
        
     