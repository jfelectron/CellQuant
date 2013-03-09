function display(cells)
%Overload display method for CellQuant.segCells

                imtypes=fieldnames(cells.segimages);
                cells.getImage(imtypes);

