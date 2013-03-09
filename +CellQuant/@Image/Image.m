classdef Image<handle
   %Container class for FISH images
   %Parse ics file, retrieve metadata and associate with object
   %Load image stack and split channels
   %.Image() returns empty objects
   %CellQuant.Image('Filename') creates object using Filename in current directory
   %CellQuant.Image('path','Filename') creates object using path/Filename 
   %
   %Jonathan Foley 6/1/2008
   
    
    properties (SetAccess=public, Dependent=true)    
        Metadata     
    end
    
    properties (SetAccess=protected,GetAccess=private,Hidden=true)
        imfile=[];
        imdir=[];
        savedir=[];
        path=[];
        ID=[]; %identifier
        Ex=[];
        channels=[];
        Em=[];
        decon=struct('SN',[],'iter',[],'q',[]);
        nch=[]; %number of channels
        zspacing=[]; %Z spacing of images
        input=[]; %input .ics image
        dimensions=[]; %[X Y Z]
    end
    
        
    

    
    methods (Access=public)
        function istack=Image(varargin) %constructor
            switch nargin
                case 0 %Create empty object
                    return;
                case 1
                    if isa(varargin{1},'char')
                        istack.imdir=pwd;
                        istack.savedir=pwd;
                        istack.loadImage(varargin{1});
    
                    else
                    display('Usage: CellQuant.Image() or CellQuant.Image(ImageFile)');
                    return
                    end
                case 2 %image file, savedir
                    istack.imdir=pwd;
                    istack.savedir=varargin{2};
                    istack.loadImage(varargin{1});
                case 3 %image file, savedir, image dir
                    istack.imdir=varargin{3};
                    istack.savedir=varargin{2};
                    istack.loadImage(varargin{3},varargin{1});

            end
            
        end
         % public prototypes
         ostack=copyobj(istack);
         loadImage(istack,varargin); 
         charray=getChannels(istack,chan)
    
    end
   
    methods
        function metadata=get.Metadata(istack) %retrieve metadata, return as structure
            metadata=struct('imfile',istack.imfile,'imdir',istack.imdir,'savedir',istack.savedir,'ID',istack.ID,'Ex',istack.Ex,'Em',istack.Em,'deconparams',istack.decon,'NCh',istack.nch,...
                'zspacing',istack.zspacing,'dimensions',istack.dimensions);
        end
    end
    
    methods (Access=protected,Hidden=true)

        parseICS(istack); %parses ICS metadata
        splitChannels(istack);   %split nD input image into n DIP_IMAGE objects, loads into a DIP_ARRAY
    end
    end

    
        
        
        
       
        
        
        
        
        
        
        
        