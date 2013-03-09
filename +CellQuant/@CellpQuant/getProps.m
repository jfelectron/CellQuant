function props=getProps(cellpop,type)

if strcmp(type,'segmentation')
    props=cellpop.segprops;
elseif strcmp(type,'FISH')
    props=cellpop.fishprops;
end
    