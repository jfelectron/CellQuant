function splitChannels(istack)
%split multidimensional image into channels
      
   istack.channels=newimar(istack.nch); %create empty dip array to store channel stacks
    for i=0:istack.nch-1
        %istack.channels{i+1}=squeeze(dip_image(istack.input(:,:,i,:,:)));
        istack.channels{i+1}=squeeze(dip_image(istack.input(:,:,:,:,i)));
        
        
    end
    istack.input=[];% no longer need input image, delete to save memory

    
    
    
        
        
   
