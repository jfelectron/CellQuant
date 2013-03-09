function flag=checkCellShape(cells,lcells)


lmeasure=measure(lcells,[],{'Size','P2A','PodczeckShapes'});
flag=0;
%tagged_ids=[];
if isempty(lmeasure) %something bad happened
    flag=2;
    return
end
for i=lmeasure.ID
    if lmeasure(i).p2a>cells.filterprops.CIRC_THRESH&&lmeasure(i).PodczeckShapes(2)<0.6
       %tagged_ids=i;
       flag=1;
       break
    end
end

end

