function savemeasure(cellpop,type,varargin)


length = numel(varargin);
temp = cellpop.getMeasure(type); %getting a copy, no risk of overwrite

if length == 0;%designating no arguments as "save all"
    Mtypes =fieldnames(temp);
    length = 4;
else
    Mtypes = varargin{1};
end


s=pwd;
cd(cellpop.savedir)    
length2 = numel(cellpop.ID);
name = cellpop.ID(2);

for k = 2:length2-1
    name = strcat(name,cellpop.ID(k+1));
end

for k = 1:length
    name = strcat(name, '_' ,Mtypes{k});
    name = char(name);
ce    savelocation = fopen(name,'a');
    fwrite(savelocation, temp.(Mtypes{k}))
    fclose(savelocation)
end

cd(s)
return
