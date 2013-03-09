function pdata=getProbeData(varargin) 

rfish=varargin{1};

    switch nargin
        case 1 %no input arg, return all measuredata
            pdata=rfish.probedata_r;
        case 2 %return specified measurement
            measuretype=varargin{2};
            if ismember(measuretype,rfish.measuretypes)
                pdata=rfish.probedata_r.(measuretype);
            else
           
        
            s=sprintf('Valid Measurement Types are: %s',rfish.measuretypes);
            display(s);   
            end
    end