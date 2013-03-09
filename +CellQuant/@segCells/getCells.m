function cellhandles=getCells(cells,varargin)

switch nargin
    case 1
        cellhandles=cells.cellhandles;
    case 2
        cellnum=varargin{1};
        cellhandles=cell(numel(cellnum));
        
        for i=1:numel(varargin{1})
            cellhandles{i}=cells.cellhandles{cellnum(i)};
        end
end
    