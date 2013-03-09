function  exportFISHimages(dir)

cells=dir([dir,'/*.mat']);

for i=1:length(cells)-1
    load(cells(i).name);
    cellObj=eval(strtok(cells(i).name,'.mat'));
    
    qFISH=cellObj.getQuant(1);
    imagetypes={'input','probe_filtered','binary_thresholded','labeled_probe','relabeled_probe'};
    
    for i=1:length(imagetypes)-1
        proj=iterate('max',qFISH.getImage({imagetypes{i}}),[],3);
        writeim(squeeze(proj),[dir,'/FISHout/',cellname,'_',imagetypes{i},'.ps'],'PS',0);
    end
    
end

