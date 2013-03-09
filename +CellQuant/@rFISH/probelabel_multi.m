function  probelabel(rfish)

       
        filterprops=rfish.filterprops;
        Imin=min(rfish.probeimages.filtered);
        Imax=max(rfish.probeimages.filtered);
        if 10>max(rfish.probeimages.filtered)
            Imax=max(rfish.probeimages.filtered);
        else
            Imax=10;
        end
        nThresh=200;
        thresholds=Imin:(Imax-Imin)/nThresh:Imax;
        counts=zeros(length(thresholds),1);
        %compute counts for many thresholds
        
        for i=1:length(thresholds)
            rfish.probeimages.labeled=label(rfish.probeimages.filtered>thresholds(i),filterprops.CONN,20,400);
            counts(i)=max(rfish.probeimages.labeled);
        end
        



         
        
       diffc=diff(counts);
       flats=find(diffc==0);
       
       %look for plateau 
        
        for k=1:length(flats)
           % if abs(diffc(k))+abs(diffc(k+1))==0||abs(diffc(k))+abs(diffc(k+1))==1
           %     break
           % end
            if flats(k+2)-flats(k)==2
                break
            end
           
        end
        k=flats(k);
        rfish.probecounts=counts;
        rfish.probethreshold=k;
     
        thresh=thresholds(k);
        rfish.filterprops.BURST_THRESH=thresh;
%         lastup=find(diffc>0,1,'last');
%         
%         thresh=thresholds(k);
%         if ~isempty(lastup)
%             i=lastup;
%            
%             while diffc(i)==0
%                 i=i+1;
%             end
%             if (i-lastup)>2
%                 lastup=lastup+floor((i-lastup)/2);
%             end
%             if lastup>k
%                 thresh=thresholds(lastup);
%             end
%         end
        
       
    
        rfish.probeimages.binary=fillholes(rfish.probeimages.filtered>thresh);
        labeled=label(rfish.probeimages.binary,filterprops.CONN,filterprops.LABEL_MIN,filterprops.LABEL_MAX);
        rfish.probeimages.labeled=labeled;
        
        
        