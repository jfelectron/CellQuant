function saveField(cellpop,currentfield,imfile)










savedir=cellpop.savedir;
imstring=strtok(imfile,cellpop.imext);
imtypes=currentfield.getSaveImages();
gfpchannel=find(ismember(cellpop.Chtypes,'GFP')==1);
fieldquantitated=0;
if isunix && ~exist([savedir,'/',imstring],'dir')
    savedir=[savedir,'/',imstring];
    mkdir(savedir)
    savedir=[savedir,'/'];
elseif isunix
    savedir=[savedir,'/',imstring,'/'];
end









 


%%save all the cell objects associated with the field
fieldcells=currentfield.getCells();
delete([savedir,'*.mat']);
delete([savedir,'*.jpg']);

for i=1:numel(fieldcells)
    
  flags=fieldcells{i}.isquantitated();
 if flags(1)
%  cellpop.ncells=cellpop.ncells+1;

 cellname=[imstring,'_',mat2str(i)];
%cellpop.cellhash=put(cellpop.cellhash,cellpop.ncells,cellname);
 savecell=sprintf('%s=fieldcells{i};',cellname);
 eval(savecell);
 save([savedir,cellname,'.mat'],cellname);
 clear(cellname);

    fieldquantitated=1;
    if ~isempty(fieldcells{i}.getCellData(1));
        
        
        loverlay=fieldcells{i}.overlaylabel(1,1);
        if ~isempty(loverlay)
            loverlayproj=iterate('max',loverlay,[],3);
            writeim(squeeze(loverlayproj),[savedir,cellname,'_fishoverlay','.jpg'],'JPEG',0);
        end
        
           fishf=fieldcells{i}.getImage(1,{'raw'});
           fishproj=iterate('max',fishf{1},[],3);
            writeim(squeeze(fishproj),[savedir,cellname,'_fishraw','.jpg'],'JPEG',0);
           
            fishf=fieldcells{i}.getImage(1,{'filtered'});
           fishproj=iterate('max',fishf{1},[],3);
           writeim(squeeze(fishproj),[savedir,cellname,'_fishfiltered','.jpg'],'JPEG',0);
      
  end
     if ~isempty(fieldcells{i}.getBurstData(1))
             boverlay=fieldcells{i}.overlayburst(1,1);
             noverlay=fieldcells{i}.overlayburst(3,1);
           if ~isempty(boverlay)
                boverlayproj=iterate('max',boverlay,[],3);
                writeim(squeeze(boverlayproj),[savedir,cellname,'_burstoverlay','.jpg'],'JPEG',0);
           end
            if ~isempty(noverlay)
                nburstproj=iterate('max',noverlay,[],3);
                writeim(squeeze(nburstproj),[savedir,cellname,'_burstnucprojection','.jpg'],'JPEG',0);
            end
    end
           
           
           
       
  end
end
  

    % write all the segmentation images to disk
    for i=1:numel(imtypes)
     saveimage=currentfield.getImage({imtypes{i}});
     writeim(saveimage,[savedir,imstring,imtypes{i} '.jpg'],'JPEG',0);
    end
    
if ~fieldquantitated
%save field object

     savefield=sprintf('%s=currentfield;',imstring);
    eval(savefield);
    save([savedir,imstring,'.field'],imstring,'-v7.3');
    clear(imstring);
end
end
    

    
    





