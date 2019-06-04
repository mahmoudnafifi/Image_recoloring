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

% Last Modified by GUIDE v2.5 03-Jun-2019 02:55:53

function varargout = gui_main(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @gui_main_OpeningFcn, ...
    'gui_OutputFcn',  @gui_main_OutputFcn, ...
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


% --- Executes just before graph_cut_gui is made visible.
function gui_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to graph_cut_gui (see VARARGIN)


handles.output = hObject;
guidata(hObject, handles);


global colors;
global objectNames;
handles.OpenM.Enable='off';
handles.GenerateM.Enable='off';
handles.Recoloring.Enable='off';
handles.PrimaryObj.Enable='off';
handles.PrimaryObj.String = "";
handles.PrimaryObj.Value = 0;

axes(handles.input_image);
img=imread('default_img.png');
imshow(img);
axes(handles.mask_image);
imshow(zeros(10,10,3));
axes(handles.colormap_image);
imshow(ones(10,10,3)*0.3);
load('color150.mat');
load('objectName150.mat');


% --- Outputs from this function are returned to the command line.
function varargout = gui_main_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

varargout{1} = handles.output;


% --- Executes on button press in open.
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FileName;
global PathName;
global image;
global mask;
global resized;
[FileName,PathName] = uigetfile({'*.jpg';'*.jpeg';'*.png';'*.tiff';...
    '*.bmp';'*.*'},'Open','../demo/input_images');
if ~isequal(FileName,0)
    image=imread(fullfile(PathName,FileName));
    
    % speed up
    if size(image,1)*size(image,2) > 800 * 800
        image=imresize(image,800/max(size(image,1),size(image,2)));
        fprintf('Warning: the image size is too large, so we resized it to %d x %d... \n', size(image,1),size(image,2));
        resized = 1;
    else
        resized = 0;
    end
    
    mask=zeros(size(image,1),size(image,2));
    axes(handles.input_image);
    imshow(image);
    axes(handles.mask_image);
    imshow(mask);
    axes(handles.colormap_image);
    imshow(ones(10,10,3)*0.3);
    handles.OpenM.Enable='on';
    handles.GenerateM.Enable='on';
    handles.Recoloring.Enable='off';
    handles.PrimaryObj.Enable='off';
    handles.PrimaryObj.String = "";
    handles.PrimaryObj.Value = 0;
end


% --- Executes on button press in OpenM.
function OpenM_Callback(hObject, eventdata, handles)
% hObject    handle to OpenM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mask;
global image;
global resized
global score
[FileName,PathName] = uigetfile({'*.png';'*.jpg';'*.jpeg';...
    '*.*'},'Open','../demo/output_masks');
if ~isequal(FileName,0)
    mask=imread(fullfile(PathName,FileName));
    if ~(resized==1) && size(mask,1)~=size(image,1) || size(mask,2)~=size(image,2) || ...
            max(mask(:))>150
        msgbox('Invalide Mask!');
        return;
    elseif resized==1 &&  max(mask(:))>150
        msgbox('Invalide Mask!');
        return;
    end
    
    if resized==1
        mask=imresize(mask,[size(image,1),size(image,2)],'nearest');
        score=imresize(score,[size(image,1),size(image,2)],'nearest');
    end
    
    axes(handles.mask_image);
    imshow(mask);
    show_mask_gui(mask,handles);
    
    if sum(mask(:))~=0
        %get primary object
        [bestObj,best,objList]=pickBestCandidate(mask);
        all_objs = [best,objList];
        objectNames = cell(0);
        for obj=1 : length(all_objs)
            objectNames = [objectNames;getObjectName(all_objs(obj))];
        end
        handles.PrimaryObj.String = objectNames;
        handles.PrimaryObj.Value = 1;
        handles.Recoloring.Enable='on';
        handles.PrimaryObj.Enable='on';
    else
        handles.PrimaryObj.String = "";
        handles.PrimaryObj.Value = 0;
    end
    
end

% --- Executes during object creation, after setting all properties.
function open_CreateFcn(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function DoD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DoD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


function show_mask_gui(mask, handles)
global colors;
global objectNames;
global rgbLab;
global colormap;
rgbLab = colorEncode_(mask, colors);
colormap = colorMap_(mask, objectNames,0.3);
axes(handles.mask_image);
imshow(rgbLab);
axes(handles.colormap_image);
imshow(colormap);


% --- Executes on button press in GenerateM.
function GenerateM_Callback(hObject, eventdata, handles)
% hObject    handle to GenerateM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global FileName;
global PathName;
global mask;
global bestObj;
global objectNames;
%global score; %in our paper, we do not use predicted mask score. It was for another application and there is no need for it in this demo (commented out).
handles.open.Enable='off';
handles.GenerateM.Enable='off';
handles.OpenM.Enable='off';
handles.Recoloring.Enable='off';
handles.PrimaryObj.Enable='off';
out.image=image;
out.FileName=FileName;
out.PathName=PathName;
out.value=100;
handles.output.UserData=out;
gui_getmask();
h = findobj('Tag','semanticMask');
% if exists (not empty)
if ~isempty(h)
    gdata = guidata(h);
    out=gdata.output.UserData;
    mask=out.mask;
    %score=out.score;
    mask=uint8(mask);
    %score=(score-min(score(:)))/(max(score(:))-min(score(:)));
    if ~isempty(mask)
        show_mask_gui(mask,handles);
        out.value=-100;
        handles.output.UserData=out;
        close(h);
        if sum(mask(:))~=0
            %get primary object
            [bestObj,best,objList]=pickBestCandidate(mask);
            all_objs = [best,objList];
            objectNames = cell(0);
            for obj=1 : length(all_objs)
                objectNames = [objectNames;getObjectName(all_objs(obj))];
            end
            handles.PrimaryObj.String = objectNames;
            handles.PrimaryObj.Value = 1;
            handles.Recoloring.Enable='on';
            handles.PrimaryObj.Enable='on';
        else
            handles.PrimaryObj.String = "";
            handles.PrimaryObj.Value = 0;
        end
    end
end


handles.open.Enable='on';
handles.GenerateM.Enable='on';
handles.OpenM.Enable='on';


% --- Executes when user attempts to close DoD.
function DoD_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to DoD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete( setdiff( findall(0, 'type', 'figure'), handles.DoD ) );
delete(hObject);



% --- Executes on button press in Recoloring.
function Recoloring_Callback(hObject, eventdata, handles)
% hObject    handle to Recoloring (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mask
global image
global FileName;
global PathName;
global bestObj;
handles.status.String='Processing...';
handles.open.Enable='off';
handles.GenerateM.Enable='off';
handles.OpenM.Enable='off';
handles.Recoloring.Enable='off';
handles.PrimaryObj.Enable='off';
pause(0.1);
%Recoloring
candidateNum=12;
out_images = image_recoloring( image, mask, candidateNum, bestObj);
out.images=out_images;
out.image=image;
out.FileName=FileName;
out.PathName=PathName;
out.value=100;
handles.output.UserData=out;
handles.status.String='Done!';
pause(0.5);
gui_recoloring();
h = findobj('Tag','recoloring');
% if exists (not empty)
if ~isempty(h)
    out.value=-100;
    handles.output.UserData=out;
    close(h);
end


handles.open.Enable='on';
handles.GenerateM.Enable='on';
handles.OpenM.Enable='on';
handles.Recoloring.Enable='on';
handles.PrimaryObj.Enable='on';


% --- Executes on selection change in PrimaryObj.
function PrimaryObj_Callback(hObject, eventdata, handles)
% hObject    handle to PrimaryObj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global bestObj;
bestObj = getObjectName(handles.PrimaryObj.Value);

% --- Executes during object creation, after setting all properties.
function PrimaryObj_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PrimaryObj (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
