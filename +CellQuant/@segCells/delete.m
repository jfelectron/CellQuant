function delete(cells)

delete(cells.field);
cells.field=[];
for i=1:numel(cells.cellhandles)
    delete(cells.cellhandles{i})
end
cells.cellhandles=[];
    