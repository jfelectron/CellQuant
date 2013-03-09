function  probelabelf(rfish)

       
        filterprops=rfish.filterprops;
        
        



         
        
    

       
    
        rfish.probeimages.binary=fillholes(rfish.probeimages.filtered>filterprops.PROBE_THRESH);
        labeled=label(rfish.probeimages.binary,filterprops.CONN,filterprops.LABEL_MIN,filterprops.LABEL_MAX);
        rfish.probeimages.labeled=labeled;