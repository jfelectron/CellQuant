function measureprobe(rfish)
props=rfish.filterprops;
     rfish.probedata=measure(rfish.probeimages.labeled,rfish.probeimages.raw,rfish.measuretypes,[],props.CONN);
     
     