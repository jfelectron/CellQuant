function reconstruct(cells)

    rec=reconstruction(cells.segimages.preprocess-cells.filterprops.DOME_HEIGHT,cells.segimages.preprocess);
    rec=cpf(rec,2);
    %rec=medif(cells.segimages.preprocess,15,'elliptic');
    %rec=cells.segimages.preprocess;
   % rec=tophat(rec,200);
    %rec=reconstruction(rec-cells.filterprops.DOME_HEIGHT/2,rec);
    cells.segimages.rec=rec;
