function  [particleIntensity,particlep2aSD]=getFISHMean(fieldDir)

cells=dir([fieldDir,'/*.mat']);
particleIntensity=[];
particlep2aSD=[];
for i=1:length(cells) 
    load(cells(i).name);
    cellObj=eval(strtok(cells(i).name,'.mat'));
    qFISH=cellObj.getQuant(1);
    probedata=qFISH.probedata.r;
    particleIntensity=[particleIntesity,probedata.Mean];
    

end
