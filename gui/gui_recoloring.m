%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Copyright (c) 2019 Mahmoud Afifi
% York University, Canada
% Email: mafifi@eecs.yorku.ca - m.3afifi@gmail.com
% Permission is hereby granted, free of charge, to any person obtaining 
% a copy of this software and associated documentation files (the 
% "Software"), to deal in the Software with restriction for its use for 
% research purpose only, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included
% in all copies or substantial portions of the Software.
%
% The Software is provided "as is", without warranty of any kind.
%
% Please cite the following work if this program is used:
% Mahmoud Afifi, Brian Price, Scott Cohen, and Michael S. Brown, Image Recoloring Based on Object Color Distributions, Eurographics 2019 - Short Papers, 2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

% Last Modified by GUIDE v2.5 04-Jun-2019 00:47:16

function varargout = gui_recoloring(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @gui_recoloring_OpeningFcn, ...
    'gui_OutputFcn',  @gui_recoloring_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before graph_cut_gui is made visible.
function gui_recoloring_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to graph_cut_gui (see VARARGIN)

handles.output = hObject;
guidata(hObject, handles);

global image;
global images;
global FileName;
global PathName;
h = findobj('Tag','DoD');
if length(h)>1
    h=h(1);
end
% if exists (not empty)
if ~isempty(h)
    % get handles and other user-defined data associated to Gui1
    gdata = guidata(h);
    out_=gdata.output.UserData;
    image=out_.image;
    images=out_.images;
    PathName=out_.PathName;
    FileName=out_.FileName;
    axes(handles.input_image);
    imshow(image);
    for i =1 : size(images,4)
        eval(sprintf('axes(handles.result%d);',i));
        imshow(images(:,:,:,i));
    end
    if size(images,4) < 12
        for i = size(images,4)+1 : 12
            eval(sprintf('axes(handles.result%d);',i));
        imshow(zeros(size(images,1),size(images,2),size(images,3)));
        end
    end
    uiwait
end

% --- Outputs from this function are returned to the command line.
function varargout = gui_recoloring_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

varargout{1} = handles.output;


% --- Executes on button press in Export.
function export_Callback(hObject, eventdata, handles)
% hObject    handle to saveas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FileName;
global PathName;
global images;
[fileName,pathName,~] = uiputfile({'*.jpg'},'Save as',fullfile(PathName,strcat(FileName(1:end-4),'_recolored.jpg')));
if ~isequal(fileName,0)
    handles.status.String='Processing...';
    pause(0.3);
    for i = 1 : size(images,4)
        imwrite(images(:,:,:,i),fullfile(pathName,[fileName(1:end-4),sprintf('_r%02d.jpg',i)]));
    end
    handles.status.String='Done!';
    pause(0.5);
    handles.status.String='';
end





% --- Executes when user attempts to close recoloring.
function recoloring_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to recoloring (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = findobj('Tag','DoD');
if length(h)>1
    h=h(1);
end
% if exists (not empty)
if ~isempty(h)
    % get handles and other user-defined data associated to Gui1
    gdata = guidata(h);
    if gdata.output.UserData.value==-100
        delete(hObject);
    else
        uiresume
    end
else
    delete(hObject);
end
