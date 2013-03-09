function removeBursts(cellpop)


rbursts=dir([cellpop.savedir,'/remove/*.jpg']);
fishchannel=find(ismember(cellpop.Chtypes,'FISH')==1);
for i=1:length(rbursts)
    filename=rbursts(i).name;
    cellname=regexp(filename,'_burstoverlay','split');
    cellname=cellname{1};
    fieldname=regexp(cellname,'R3D','split');
    fieldname=[fieldname{1},'R3D'];
    load([cellpop.savedir,'/',fieldname,'/',cellname,'.mat']);
    eval(sprintf('curcell=%s;',cellname));
    burstdata=curcell.getBurstData(fishchannel);
    if length(burstdata)>1
        disp(cellname);
        allbursts=input('Remove All Bursts?');
        if strcmp(allbursts,'Y')
                remove=[1:length(burstdata)];
                curcell.removeBurst(fishchannel,remove);
         
        else
            remove=input('Which Bursts (e.g. [1,2]?');
            if ~isempty(remove)
           
                   curcell.removeBurst(fishchannel,remove);

            end
        end
    else
        curcell.removeBurst(fishchannel,1);
    end
    cellpop.resavecell(fieldname,cellname,curcell);
end


