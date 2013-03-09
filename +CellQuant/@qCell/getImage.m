function varargout=getImage(qcell,varargin)
if ~isempty(varargin)
 if nargin==3
    channels=varargin{1};
    types=varargin{2};
    varargout=cell(numel(channels),numel(types));
    for i=1:numel(channels)
        for j=1:numel(types)
            type=types{j};
            if ismember(type,fieldnames(qcell.imtypes))
                type=qcell.imtypes.(type);
                varargout{i,j}={qcell.(type){channels(i)}};
                if ~nargout && ~isempty(varargout{i,j})
                    h=dipshow(varargout{i,j});
                    if strcmp('labels',type)
                    dipmapping(h,'labels');
                    end
                end
            else
                display('Not a valid image types');
                display('Valid image types are:');
                display(fieldnames(qcell.imtypes));
                varargout=[];
            end
        end

    end
    if ~nargout
        varargout=[];
    end
 else
    display('Error: Usage qCell.getImage(channels,''type''');
 end
else
    display('Image types are:');
    display(fieldnames(qcell.imtypes));
end