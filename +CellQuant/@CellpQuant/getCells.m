function cells=getCells(cellpop,varargin)

switch narargin
    case 1
        cells=cellpop.currentfield.getCells();
    case 2
        cellnums=varargin{1};
        cells=cellpop.currentfield.getCells(cellnums);
end
        