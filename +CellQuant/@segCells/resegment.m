function [lcells,flag]=resegment(cells,lcells,manual,display)

    flag=checkCellShape(cells,lcells);
    
    %try to recover by lowering MASK_THRESH 
    if flag==1
     
      
            cells.checkseg=1;

    
    
       
      
%Auto recovery has failed so either bail if in silent mode or go manual
    
        if cells.silent
           flag=2;
           return
        end
    else 
        return
        
    end
        
    grey_img=cells.segimages.preprocess;
    cellcheck=lcells>0;
        if ~cells.silent
            flag=1;
        
       
          cellskel=cells.segimages.cellskeleton;
          lborder=overlay(grey_img,cellskel);
          %loverlay=overlay(grey_img,lcells);
          dipfig(17,'loverlay')
        dipshow(lborder);
        diptruesize(17,50);
            reseg=input('Resegment?');  
             if strcmp(reseg,'N')
              %  cells.requant=0;
              %  cells.checkseg=0;
              
                return
             end
            cells.requant=1;
            mthresh=input('New Mask threshold (Enter 0 for no change)?');
            if mthresh
                cells.filterprops.MASK_THRESH=mthresh;
                cells.maskcells();
                cells.cellseeds(); 
            end
            reseed=input('Reseed?');
            if strcmp(reseed,'Y')
                reseed=1;
            else
                reseed=0;
            end
           
            
       
       
            
      else
        return;
      end





    %find mask of tagged segments
if ~cells.silent    

  while 1  
    %regions = tagged*grey_img;
    if reseed
    coords = [];  
               cellcheck=lcells>0;
          cellskel=cells.segimages.cellskeleton;
          lborder=overlay(grey_img,cellskel);
          dipfig(17,'lborder')
        dipshow(lborder);
        diptruesize(17,50);
        %collect click locations for new seed
        while 1
         fprintf('Click to locate new seeds. Right/Ctrl click to exit.\n');
         seedcoords=dipgetcoords(17,1);
         if seedcoords(1)==-1 & seedcoords(2)==-1 break; end
         coords=[coords;seedcoords];
        end
                 

    %create new seeds at click locations
    segments=cellcheck;
    newseeds = newim(segments,'bin');
    for coord = coords'
        newseeds(coord(1),coord(2)) = 1;
    end
    newseeds = bdilation(newseeds,10,-1);
   %newseeds=newseeds&tagged;
    cells.segimages.cellseeds=label(newseeds);
    end
lcells=dip_growregions(cells.segimages.cellseeds,cells.segimages.dt,cells.segimages.cellmask,...
    2,10,'high_first');
lcells=dip_growregions(lcells,cells.segimages.rec,cells.segimages.cellmask,...
    2,10,'high_first');

          lborder=overlay(grey_img,lcells);
          dipfig(17,'lborder')
        dipshow(lborder);
        diptruesize(17,50);
cont=input('Satisfied?');
if strcmp(cont,'Y')
    break
end
 mthresh=input('New Mask threshold (Enter 0 for no change)?');
  reseed=input('Reseed?');
            if strcmp(reseed,'Y')
                reseed=1;
            else
                reseed=0;
            end
           
 if mthresh
    cells.filterprops.MASK_THRESH=mthresh;
    cells.maskcells();
    cells.cellseeds(); 
 end
           
  end
  
elseif exist('tagged_ids','var')
    flag=2;
    return
end
    
    
