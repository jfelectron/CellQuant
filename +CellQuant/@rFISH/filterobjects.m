function filterobjects(rfish)

       if ~isempty(rfish.probedata)
%        if rfish.training
%            rfish.trainFISH();
%         else
%             rfish.classify();
%         end
           
        reject=find((rfish.probedata.p2a>rfish.filterprops.P2A_MAX|rfish.probedata.stddev<rfish.filterprops.GREY_SDMAX)|(rfish.probedata.p2a<rfish.filterprops.P2A_MIN|rfish.probedata.stddev<rfish.filterprops.GREY_SDMAX));
        %reject=find((rfish.probedata.p2a>rfish.filterprops.P2A_MAX&rfish.probedata.stddev<rfish.filterprops.GREY_SDMAX)|(rfish.probedata.p2a<rfish.filterprops.P2A_MIN&rfish.probedata.stddev<rfish.filterprops.GREY_SDMAX)|rfish.probedata.sum<1000);
        rfish.detectburst();
        if ~isempty(rfish.burstdata_r)
            burst=rfish.burstdata_r.id;
            %reject=[reject,burst];
        end
       
      

        rfish.doublets=find(rfish.probedata.p2a>1.15&rfish.probedata.stddev>2);
        rfish.probeimages.labeled_r=rfish.probeimages.labeled;
        for i=1:length(reject)
            rfish.probeimages.labeled_r(rfish.probeimages.labeled_r==reject(i))=0;
        end 
        
       end
        end
