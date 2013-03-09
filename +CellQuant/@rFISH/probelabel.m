function  probelabel(rfish)

       
        filterprops=rfish.filterprops;
        rfish.probeimages.binary=fillholes(rfish.probeimages.filtered>filterprops.PROBE_THRESH);
        labeled=label(rfish.probeimages.binary,filterprops.CONN,filterprops.LABEL_MIN,0);
        rfish.probeimages.labeled=labeled;