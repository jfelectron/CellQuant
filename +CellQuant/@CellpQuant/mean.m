function mean(cellpop,type,Mtypes)
length = numel(Mtypes);
meanvals = zeros(1,length);
output = '';
for k = 1:length
    meanvals(k) = mean(cellpop.getMeasure(type).(Mtypes{k}));
    output = sprintf('%sThe mean %s is %f\n',output,Mtypes{k},meanvals(k));
end
fprintf('%s',output)
return