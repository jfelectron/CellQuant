function mansegment(cellpop,type)




for i=1:length(cellpop.filenames)
       
         
         if isempty(cellpop.filenames(i).segmented)
             imfile=cellpop.filenames(i).name;
             cellpop.filenames(i).name
        
              tic
             if strcmp(type,'all')||strcmp(type,'segment')
              currentfield=cellpop.runsegmentation(imfile,0);
            end
            if strcmp(type, 'all')||strcmp(type, 'quantitate')%&&currentfield.status('quantitate')
                   currentfield=cellpop.runquantitation(currentfield);
            end
                

            if currentfield.issegmented()
                cellpop.filenames(i).segmented=1;
                cellpop.addField(imfile);
                cellpop.saveField(currentfield,imfile);
                
                %save([cellpop.savedir,'/a.mat'],'cellpop');
                clear currentfield
                toc
            end
         end
end
