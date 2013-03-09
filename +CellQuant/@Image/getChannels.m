   function charray=getChannels(istack,chan)
                nch=length(chan);
           
                if nch>1
                    charray=newimar(nch);
                    for i=1:nch
                        charray{i}=istack.channels{chan(i)};
                    end
                else
                    charray=istack.channels{chan(1)};
                
                end
            