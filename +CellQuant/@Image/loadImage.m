function loadImage(istack,varargin)
switch nargin
        case  2 
            if isa(varargin{1},'char')
                istack.path=pwd;
                istack.imfile=varargin{1}; %assume file is in current directory
                flag=1;
            else
                display('Usage: Filename or Path,Filename');
            end
        case 3
            if isa(varargin{1},'char') && isa(varargin{2},'char') %both path and file are given
                istack.path=varargin{1};
                istack.imfile=varargin{2};
            else
             display('Usage: Filename or Path,Filename');
            end
end
if ~isempty(istack.imfile)
    istack.input=readim(strcat(istack.path,'/',istack.imfile));
    parseICS(istack);
    splitChannels(istack);
end   
                
            