function detectburst(rfish)


        
         filterprops=rfish.filterprops;
        likelyBursts=find(rfish.probedata.stddev>filterprops.BURST_MINSD);
     
        
      
       
        if ~isempty(likelyBursts)
            likelyBurstData=rfish.probedata(likelyBursts);
            candidateBurst=[];
  
            if numel(likelyBursts)>1
                candidateBurst=find(rfish.probedata.stddev==max(likelyBurstData.stddev));
                if numel(candidateBurst)>1
                    candidateBurst=find(rifsh.probedata.sum==max(likelyBurstData.stddev));
                end
            else
                candidateBurst=likelyBursts;
            end
      
       if ~isempty(candidateBurst)
           
            rfish.probeimages.burst_labeled_r=rfish.probeimages.labeled==candidateBurst;
  
            rfish.burstdata_r=rfish.probedata(candidateBurst);
       end
       end
      end
       
      
     
     
      
