function cellseeds(cells)


    cells.segimages.dt=dt(cells.segimages.rec>cells.filterprops.DT_THRESH*CellQuant.otsu(cells.segimages.rec));
    cells.segimages.dt_binary=cells.segimages.dt>cells.filterprops.SEED_THRESH;
   % cells.segimages.dt_binary=berosion(cells.segimages.dt_binary,cells.filterprops.ERS_ITER,cells.filterprops.DIL_SE,0);
   gfpseeds=label(cells.segimages.dt_binary,2,cells.filterprops.MIN_SEED_SIZE,0);
   % gfpseeds=gfpseeds*cells.segimages.cellmask;
   % gfpseeds=gfpseeds>0;
    
   % gfpseeds=label(gfpseeds);
    
   %cells.segimages.cellseeds=gfpseeds;
   %seedsection_b=cells.segimages.seedsection>CellQuant.otsu(cells.segimages.seedsection)*cells.filterprops.SEED_THRESH;
   %seedsection_b=fillholes(bdilation(seedsection_b,cells.filterprops.DIL_ITER,cells.filterprops.DIL_SE,0));
   %seedsection_l=label(fillholes(seedsection_b),2,cells.filterprops.MIN_SEED_SIZE,0)
   %cells.segimages.nuc_binary=fillholes(seedsection_b);
   %nucseeds=label(fillholes(seedsection_b),2,cells.filterprops.MIN_SEED_SIZE,0);
   
   cells.segimages.cellseeds=gfpseeds;
  
   %cells.segimages.cellseeds=nucseeds;
%   if max(gfpseeds)>=max(nucseeds)
%      cells.segimages.cellseeds=gfpseeds;
%    else
%        cells.segimages.cellseeds=nucseeds;
%   end
   
 