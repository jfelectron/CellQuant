function setChannels(cellpop,channels)

%parse user supplied channels input string with whitespace token

[T,R]=strtok(channels);
chan={T};

while ~isempty(R)
    [T,R]=strtok(R);
    chan=[chan,{T}];
end

cellpop.Chtypes=chan;
