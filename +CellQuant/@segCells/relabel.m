function relabel(cells)

lcells=cells.segimages.celllabels;

ids=unique(dip_array(lcells));
ids=ids(2:length(ids));

nids=1:length(ids);

for i=1:length(ids)
    lcells(lcells==ids(i))=nids(i);
end

cells.segimages.celllabels=lcells;

