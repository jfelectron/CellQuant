function localization(qcell,nucchannel,fishchannels)

for k=1:length(fishchannels)
fishchannel=fishchannels(k);
nucf=threshold(qcell.raw{nucchannel},'isodata'); %segment nucleus
L=qcell.labels{fishchannel};
dims=size(nucf);
nSlices=dims(3);
for i=0:nSlices-1;
nucf(:,:,i)=dip_image(imfill(dip_array(nucf(:,:,i)),'holes')); %fill holes
end
Nkeep=[];
    Ckeep=[];
    NkeepG=[];
    CkeepG=[];
    border=[];
if ~isempty(L)
    N=L*nucf;
    C=L*~nucf;
    
    for i=1:max(L)
        Npix=length(find(N==i));
        Cpix=length(find(C==i));
    if Npix&&Cpix
        border=[border,i]; %keep track of those on border
        NkeepG=[NkeepG,i]; %Greedy assignment
    if Npix>=Cpix %pixel weighted assignment
        Nkeep=[Nkeep,i];
    end
    elseif Npix
        NkeepG=[NkeepG,i];
        Nkeep=[Nkeep,i];
end
end
 CkeepG=setdiff(1:max(L),NkeepG);
 Ckeep=setdiff(1:max(L),Nkeep);
 qcell.labeled_NG{k}=NkeepG;
 qcell.labeled_CG{k}=CkeepG;
 qcell.labeled_NW{k}=Nkeep;
 qcell.labeled_CW{k}=Ckeep;
 

end

 qcell.locdata{k}=struct('N_greedy',NkeepG,'C_greedy',CkeepG,'N_weighted',Nkeep,'C_weighted',Ckeep,'edge',border);

 
end
