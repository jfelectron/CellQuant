function delete(qcell)

for i=1:numel(qcell.qobjs)
    delete(qcell.qobjs{i});
end