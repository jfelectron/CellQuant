function segmentCells(cells,varargin)
    cells.preprocess();
    cells.reconstruct();
   % cells.nucseeds();
    cells.maskcells();
    cells.cellseeds();        
    flag=cells.growregions(0,1);
    
        
    if flag
        cells.cropCells();
        cells.segmented=1;
    end
    switch nargin
        case 1 %silent segmentation
            return
        case 2
            
            for i=1:length(varargin)
                try
                    cells.(cell2mat(varargin{i}));
                catch
                    display('Input cell array of desired functions to run after segmentation');
                    
                    return
                end
            end
               
            
    end
            

    
    
    