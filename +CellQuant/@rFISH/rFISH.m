classdef rFISH<handle
    properties (SetAccess=public)
        training=0;
    end
    properties (Access=public)
        probeimages=struct('raw',[],'filtered',[],'filteredG',[],'binary',[],'burst_binary',[],'labeled',[],'labeled_r',[],'burst_labeled',[],'burst_labeled_r',[]);
        probechannels=[];
     
        filterprops=[]; %structure containing all rISH filter parameters on per channel basis
        probedata=[]; 
        burstdata=[];
        burstdata_r=[];
        probedata_r=[];
        probethreshold=[];
        probecounts=[];
        doublets=[];
        measuretypes={'size','p2a','mean','stddev','sum'}; %cell array of measurement types that are computed for the probe
        imagetypes=struct('input','raw','probe_filtered','filtered','binary_thresholded','binary',...
                    'labeled_probe','labeled','relabeled_probe','labeled_r','burst','burst_labeled','burst_relabeled','burst_labeled_r');
    
    end
    
    properties (Dependent=true)
        filterproperties; %access to this returns public mutable filter properties
    end
    
    methods (Access=public)
        function rfish=rFISH(probechannels,varargin)
            if nargin==2
                rfish.filterprops=varargin{1};
            end
            for i=1:length(probechannels)
                if isa(probechannels{i},'dip_image')
                    rfish(i).probeimages.raw=probechannels{i};  
                
                else
                display('Usage: rFISH(probestack1,probestack2...');
                end
            end
        end
     
       
        
        setFilterProp(rfish,channel,prop) %sets selected prop in pfilterprops
        trainFISH(rfish,channels);
        countFISH(rfish,channels) %quantitate FISH signals in specified channels
        varargout=getImage(rfish,varargin)
        pdata=getProbeData(varargin)
        bdata=getBurstData(varargin)
        removeBurst(rfish,burstid);
        reprocess(rfish,func) %Testing level access....remove once done testing
        display(rfish)
       
    end
    
    methods 
         function  filtprops=get.filterproperties(rfish)
             filtprops= struct('ProbeThreshold',filterprops.PROBE_THRESH,'ProbeMinSize',filterprops.LABEL_MIN,...
                    'ProbeMaxSize',filterprops.LABEL_MAX,'CircularityThreshold',filterprops.P2A_THRESH);
         end
    end
   
    methods (Access=protected,Hidden=true)
        probefilter(rfish);%filters input image
        classify(rfish);
        probelabel(rfish); %generate binary and labels probe objects
        measureprobe(rfish); %measures probe objects
        filterobjects(rfish); %filters objects based on object properties
        relabel(rfish); %relabel and remeasure objects
        detectburst(rfish);
    end
end
        
        
        
        
        
        