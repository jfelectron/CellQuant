function getID(cellpop)

pfname=regexp(cellpop.imfile,'_','split');
fdate=regexp(date,'-','split');
fdate=strcat(fdate(1), fdate(2),fdate(3));
cellpop.ID=strcat(cell2mat(pfname(1)), cell2mat(pfname(2)), '_' ,fdate);

