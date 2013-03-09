function varargout=getImage(rfish,varargin)


if ~isempty(varargin)
    imtypes=varargin{1};
    for i=1:length(imtypes)
        
       imtype=imtypes{i};
     
        if ischar(imtype)&&ismember(imtype,fieldnames(rfish.imagetypes))
            imtype=rfish.imagetypes.(imtype);
            if ~nargout
                h=dipshow(rfish.probeimages.(imtype));
                if ~isempty(strfind(imtype,'labeled'));
                    dipmapping(h,'labels');
                end
            end
            if nargout
                if ~exist('oimage','var')
                    oimage=cell(length(imtypes),1);
                end
                oimage{i}=rfish.probeimages.(imtype);
            end
        else
            display('Please provide image type:')
            display(fieldnames(rfish.imagetypes))
            return
        end
    end
    if nargout
        varargout=oimage;
    else
        varargout=[];
    end
else
  display('Please provide image type:')
            display(fieldnames(rfish.imagetypes))
            varargout=[];
end