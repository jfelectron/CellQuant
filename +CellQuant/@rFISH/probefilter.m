function probefilter(rfish)


    filterprops=rfish.filterprops;
    rfish.probeimages.filtered=tophat(rfish.probeimages.raw,filterprops.TH_SIZE,filterprops.TH_SHAPE,filterprops.TH_TYPE,filterprops.TH_COLOR);
    %rfish.probeimages.filtered=medif(rfish.probeimages.raw,3);
    LoG15=-laplace(gaussf(rfish.probeimages.filtered,1.5),1.5);
    LoG15(LoG15<0)=0;                                                                                                                                                                                                                                        
    rfish.probeimages.filtered=LoG15;
                                                                                                                        % rfish.probeimages.filteredG=gradmag(rfish.probeimages.filteredT,filterprops.GRAD_SIGMA);

     % prev parameters thresh 2.5, P2A_MIN 0.96                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           