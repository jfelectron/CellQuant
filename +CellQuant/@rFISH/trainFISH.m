function trainFISH(rfish)
    dipshow(iterate('max',rfish.probeimages.filtered,[],3));
    labelmax=squeeze(iterate('max',rfish.probeimages.labeled,[],3));
    h=dipshow(labelmax,'labels');
    labels=zeros(1,max(rfish.probeimages.labeled));
    for i=1:max(rfish.probeimages.labeled)
        labelmax=squeeze(iterate('max',rfish.probeimages.labeled==i,[],3));
        dipfig labelmax
        labels(i)=input('Classify: (0) Bad (1) Good :  ');
        
    end
    labels
end

