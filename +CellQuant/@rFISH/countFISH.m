function countFISH(rfish)

            rfish.probefilter();
            rfish.probelabel();
            rfish.measureprobe();
           if ~isempty(rfish.probedata)
                 rfish.filterobjects();
                 rfish.relabel();
               
           end
           
        
            

