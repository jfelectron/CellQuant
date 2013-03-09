function maskcells(cells)

%binary mask from reconstructed image based on multiple of ostu threshold

%[o,t]=threshold(cells.segimages.rec,'triangle');
%cells.segimages.cellmask=fillholes(cells.segimages.rec>cells.filterprops.MASK_THRESH*t);

cells.segimages.cellmask=fillholes(cells.segimages.rec>cells.filterprops.MASK_THRESH*CellQuant.otsu(cells.segimages.rec)); 

