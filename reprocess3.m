

clones={'IC4','ID3','BC6'};

basedir='/auto/sahara/namib/home/jefoley/LGM2_NSA_Noise/';

for i=1:length(clones)
    load([basedir,'LGM2_',clones{i},'/processed/cellpop.mat']);
    cellpop.process('requantitate',1);
   clearvars -except clones basedir i
    
end
