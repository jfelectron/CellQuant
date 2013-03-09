function lcells=cellcheck(cells,lcells)

    bcells=newim(size(lcells));
    lmeasure=measure(lcells,[],{'size'});
    cells.segimages.cellskeleton=bcells;
for i=lmeasure.id; %loop through all the cells in the segmented label image
    cellcheck=zeros(size(lcells));
    if (lmeasure(i).Size>1000)
        cellcheck(lcells==i)=1;
        cellcheck=cellcheck>0;
        cellcheck=brmedgeobjs(cellcheck);
    end
   
    cellskel=gradmag(dip_image(cellcheck,'dfloat'),0.2)>0.5;
    cells.segimages.cellskeleton=cells.segimages.cellskeleton+cellskel;
    bcells=bcells+cellcheck;
end
    lcells(bcells==0)=0; %return labeled image with edge objects removed