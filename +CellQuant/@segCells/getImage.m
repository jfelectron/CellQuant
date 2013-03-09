function varargout=getImage(cells,varargin)


if ~isempty(varargin)
    imtypes=varargin{1};
    for i=1:length(imtypes)
        
       imtype=imtypes{i};
     
        if ischar(imtype)&&ismember(imtype,fieldnames(cells.segimages))
            if ~nargout
                h=dipshow(cells.segimages.(imtype));
                diptruesize(h,50);
                if ismember(imtype,cells.labelimages);
                    dipmapping(h,'labels');
                end
            end
            if nargout
                if ~exist('oimage','var')
                    oimage=cell(length(imtypes),1);
                end
                oimage{i}=cells.segimages.(imtype);
            end
        else
            display('Please provide image type:')
            display(fieldnames(cells.segimages))
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
            display(fieldnames(cells.segimages))
            varargout=[];
end