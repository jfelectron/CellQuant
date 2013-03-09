function  exportFISHimages(fieldDir)

cells=dir([fieldDir,'/*.mat']);
mkdir([fieldDir,'/FISHout']);
for i=1:length(cells)
    load(cells(i).name);
    cellObj=eval(strtok(cells(i).name,'.mat'));
    cellname=strtok(cells(i).name,'.mat');
    qFISH=cellObj.getQuant(1);
    imagetypes={'input','probe_filtered','binary_thresholded','labeled_probe','relabeled_probe'};
    
    for j=1:length(imagetypes)
        proj=iterate('max',qFISH.getImage({imagetypes{j}}),[],3);
        writeim(squeeze(proj),[fieldDir,'/FISHout/',cellname,'_',imagetypes{j},'.jpg'],'JPEG',0);
    end
    
end

