function nucseeds(cells)

seedsection_b=cells.segimages.seedsection>CellQuant.otsu(cells.segimages.seedsection);
seedsection_b=fillholes(seedsection_b);
cells.segimages.cellseeds=label(seedsection_b,2,cells.filterprops.MIN_CELL_SIZE);
cells.segimages.seed_overlay=overlay(cells.segimages.midsection,cells.segimages.cellseeds);



