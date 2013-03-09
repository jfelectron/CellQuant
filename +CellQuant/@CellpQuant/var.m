function var(cellpop,type,Mtypes)
length = numel(Mtypes);
varvals = zeros(1,length);
output = '';
for k = 1:length
    varvals(k) = var(cellpop.getMeasure(type).(Mtypes{k}));
    output = sprintf('%sThe variance of %s is %f\n',output,Mtypes{k},varvals(k));
end
fprintf('%s',output)
return