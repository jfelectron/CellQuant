
function out=loadAllClones()
    basedir='/auto/sahara/namib/home/jefoley/LGM2_NSA_Noise/';
    cd(basedir);
    fd=dir();
    savedir='/auto/sahara/namib/home/jefoley/fitting/FISH_data3/';
    savedirN='/auto/sahara/namib/home/jefoley/fitting/FISH_data3n/';
    savedirC='/auto/sahara/namib/home/jefoley/fitting/FISH_data3c/';
     out=struct();
    for j=3:length(fd)
        if fd(j).isdir
        cd([basedir,fd(j).name,'/processed/']);
        load('cellpop.mat','cellpop');
        cellpop.loadCelldata();
        save('cellpop.mat','cellpop');
        counts=cellpop.getMeasure('cells').Transcripts;
        ncounts=cellpop.getMeasure('cells').TNuc;
        ccounts=cellpop.getMeasure('cells').TCyt;
        save([savedir,fd(j).name,'.mat'],'counts');
        save([savedirN,fd(j).name,'.mat'],'ncounts');
        save([savedirC,fd(j).name,'.mat'],'ccounts');
        out.(fd(j).name)=cellpop;
        clear cellpop
        end
    end
        
        
        
end
