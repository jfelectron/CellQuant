function scatter(cellpop,type,Mtypes)
length = numel(Mtypes);
if length ~=2
    fprintf('Please input exactly two measures for a scattergram')
    return
end
output = '';
figure
scatter(cellpop.getMeasure(type).(Mtypes{1}), cellpop.getMeasure(type).(Mtypes{2}))
name = ['Scattergram of ' type ' ' Mtypes{1} ' vs.' Mtypes{2}];
title(name)
switch Mtypes{1}
    case 'sum'
        xlabel('integrated pixel sum')
    case 'size'
        xlabel('sizes (pixels)')
    case 'P2A'
        xlabel('circularity (P2A Ratio)')
    case 'SurfaceArea'
        xlabel('Surface Area (pixels)')
end

switch Mtypes{2}
    case 'sum'
        ylabel('integrated pixel sum')
    case 'size'
        ylabel('sizes (pixels)')
    case 'P2A'
        ylabel('circularity (P2A Ratio)')
    case 'SurfaceArea'
        ylabel('Surface Area (pixels)')
end


savename = [cellpop.savedir '_' cellpop.getID '_' type '_' Mtypes{1} 'vs' Mtypes{2}];
saveas(gcf, savename, 'jpeg')
return