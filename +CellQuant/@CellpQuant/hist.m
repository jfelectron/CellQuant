function hist(cellpop,type,Mtypes)
length = numel(Mtypes);
output = '';
for k = 1:length
    figure
    hist(cellpop.getMeasure(type).(Mtypes{k}))
    name = ['Histogram of ' type ' ' Mtypes{k} ' values'];
    title(name)
    ylabel('frequency')
    switch Mtypes{k}
        case 'sum'
            xlabel('integrated pixel sum')
        case 'size'
            xlabel('sizes (pixels)')
        case 'P2A'
            xlabel('circularity (P2A Ratio)')
        case 'SurfaceArea'
            xlabel('Surface Area (pixels)')
    end
    savename = [cellpop.savedir '_' cellpop.getID '_' type '_' Mtypes{k}];
    saveas(gcf, savename, 'jpeg')      
end
return