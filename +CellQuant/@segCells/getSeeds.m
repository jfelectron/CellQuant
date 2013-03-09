function seedimages=getSeeds(cells)

seedimages=newimar(2);

seedimages{1}=cells.segimages.gfpseeds;
seedimages{2}=cells.segimages.nucseeds;

