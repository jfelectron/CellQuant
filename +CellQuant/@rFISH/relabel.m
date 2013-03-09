function relabel(rfish)

if max(rfish.probeimages.labeled_r)>0
    rfish.probeimages.labeled_r=label(rfish.probeimages.labeled_r);
    rfish.probedata_r=measure(rfish.probeimages.labeled_r,rfish.probeimages.raw,rfish.measuretypes);
end