function flag=status(cells,type).
   
if strcmp(type,'quantitate')
    flag=cells.requant;
elseif strcmp(type,'segment');
    flag=cells.checkseg;
end
    