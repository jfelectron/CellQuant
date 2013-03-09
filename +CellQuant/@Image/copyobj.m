function ostack=copyobj(istack)

        ostack=CellQuant.Image(); %create empty Image object
        ostack.imfile=istack.imfile;
        ostack.path=istack.path;
        ostack.ID=istack.ID; %identifier
        ostack.Ex=istack.Ex;
        ostack.channels=istack.channels;
        ostack.Em=istack.Em;
        ostack.decon=istack.decon;
        ostack.nch=istack.nch; %number of channels
        ostack.zspacing=istack.zspacing; %Z spacing of images
        ostack.input=istack.input; %input .ics image
        ostac.dimensions=istack.dimensions; %[X Y Z]