function requant(cellpop)

fishchannels=find(ismember(cellpop.Chtypes,'FISH')==1);
for i=1:cellpop.nfields
    field=get(cellpop.fieldhash,i);
    fielddir=[cellpop.savedir,'/',field,'/'];
    cells=dir([fielddir,'*.mat']);
    for j=1:numel(cells)
        try
        load([fielddir,cells(j).name])
        flag=1;
        catch
            disp('File load error');
            flag=0;
        end
        if flag
        cellname=strtok(cells(j).name,'.mat');
        cellnumber=regexp(cellname,'R3D_','split');
        cellnumber=str2double(cellnumber{2});
        eval(sprintf('curcell=%s;',cellname));
        curcell.setFilterProps(cellpop.fishprops);
        curcell.quantitateFISH(fishchannels);
        savecell=sprintf('%s=curcell;',cellname);
        eval(savecell);
 
    save([fielddir,cellname,'.mat'],cellname);
  flags=curcell.isquantitated();
 if flags(1)
    if ~isempty(curcell.getCellData(1));
        loverlay=curcell.overlaylabel(1,1);
        if ~isempty(loverlay)
            loverlayproj=iterate('max',loverlay,[],3);
            writeim(squeeze(loverlayproj),[fielddir,cellname,'_fishoverlay','.jpg'],'JPEG',0);

        end
       
           fishf=curcell.getImage(1,{'raw'});
           fishproj=iterate('max',fishf{1},[],3);
            writeim(squeeze(fishproj),[fielddir,cellname,'_fishproj','.jpg'],'JPEG',0);
    end
     if ~isempty(curcell.getBurstData(1))
             boverlay=curcell.overlayburst(1,1);
             noverlay=curcell.overlayburst(3,1);
           if ~isempty(boverlay)
                boverlayproj=iterate('max',boverlay,[],3);
                writeim(squeeze(boverlayproj),[fielddir,cellname,'_burstoverlay','.jpg'],'JPEG',0);
           end
            if ~isempty(noverlay)
                nburstproj=iterate('max',noverlay,[],3);
                writeim(squeeze(nburstproj),[fielddir,cellname,'_burstnucprojection','.jpg'],'JPEG',0);
            end
    end
           
           
           
       

 end
        end
    end
end
   

