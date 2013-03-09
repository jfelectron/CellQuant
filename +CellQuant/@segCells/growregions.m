function flag=growregions(cells,manual,display)

 lcells=dip_growregions(cells.segimages.cellseeds,cells.segimages.dt,cells.segimages.cellmask,...
     2,10,'high_first');
 
lcells=dip_growregions(lcells,cells.segimages.rec,cells.segimages.cellmask,...
     2,10,'high_first');
%lcells=relabel(lcells);
lcells=cells.cellcheck(lcells);
[lcells,flag]=cells.resegment(lcells,manual,display);

if flag~=2
    if flag==1
        lcells=cells.cellcheck(lcells);
    end
    cells.segimages.celllabels=lcells;
    cells.relabel(); %relabel to make labels consecutive
    cells.segimages.seed_overlay=overlay(cells.segimages.rec,cells.segimages.cellseeds);
    cells.segimages.label_overlay=overlay(cells.segimages.rec,cells.segimages.celllabels);
    cells.segimages.skeleton_overlay=overlay(cells.segimages.rec,cells.segimages.cellskeleton);
    flag=1;
else
    flag=0;
end
    
    
