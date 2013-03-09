
function out=loadClones(cloneList)
    basedir='/auto/sahara/namib/home/jefoley/LGM2_NSA_Noise/';
    savedir='/auto/sahara/namib/home/jefoley/fitting/FISH_data3/';
    savedirN='/auto/sahara/namib/home/jefoley/fitting/FISH_data3n/';
    savedirC='/auto/sahara/namib/home/jefoley/fitting/FISH_data3c/';
     out=struct();
    for j=1:length(cloneList)
        cloneList(j)
        cd([basedir,'/LGM2_',cloneList{j},'/processed']);
        load('cellpop.mat','cellpop');
        cellpop.loadCelldata();
        save('cellpop.mat','cellpop');
        counts=cellpop.getMeasure('cells').Transcripts;
        ncounts=cellpop.getMeasure('cells').TNuc;
        ccounts=cellpop.getMeasure('cells').TCyt;
        save([savedir,'LGM2_',cloneList{j},'.mat'],'counts');
        %save([savedir2,'LGM2_',cloneList{j},'c.mat'],'ccounts');
        out.(cloneList{j})=cellpop;
        clear cellpop
    end
        
        
        
end
