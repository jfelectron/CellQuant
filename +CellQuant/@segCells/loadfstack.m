function loadfstack(cells,istack)

%load desired fluorescent channel and retrieve middle slice for
%segmentation
nsect=istack.Metadata.dimensions(3);
%nsect=istack.Metadata.dimensions(4);
fstack=istack.getChannels(cells.segchannel);
seedstack=istack.getChannels(cells.seedchannel);
cells.field=istack;
cells.Metadata=istack.Metadata;
cells.segimages.midsection=squeeze(iterate('max',fstack,[],3));
cells.segimages.seedsection=squeeze(iterate('max',seedstack,[],3));

