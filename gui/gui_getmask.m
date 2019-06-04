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

% Last Modified by GUIDE v2.5 04-Jun-2019 00:27:57

function varargout = gui_getmask(varargin)


gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @gui_getmask_OpeningFcn, ...
    'gui_OutputFcn',  @gui_getmask_OutputFcn, ...
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
function gui_getmask_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to graph_cut_gui (see VARARGIN)


handles.output = hObject;

guidata(hObject, handles);


global colors;
global objectNames;
global auto_support;
global default_gpu;
global image;
global mask;
global old_mask;
global score;
global old_score;
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
    PathName=out_.PathName;
    FileName=out_.FileName;
    %default_gpu=1;
    default_gpu=0;
    axes(handles.input_image);
    mask=zeros(size(image,1),size(image,2));
    score=zeros(size(image,1),size(image,2));
    old_mask=mask; %old_score=score;
    imshow(image);
    axes(handles.mask_image);
    imshow(zeros(10,10,3));
    axes(handles.colormap_image);
    imshow(ones(10,10,3)*0.3);
    load('color150.mat');
    load('objectName150.mat');
    
    %load available CNNs
    default_cnn='refinenet';
    myDir=dir('../SS_CNN');
    myDir = myDir(find(vertcat(myDir.isdir)));
    myDir = myDir(find(~cellfun(@isdir,{myDir(:).name})));
    myDir = myDir(arrayfun(@(x) x.name(1), myDir) ~= '.');
    if ~isempty(myDir)
        auto_support=true;
        cnn_names = lower({myDir(:).name});
        set(handles.cnn_name,'String',cnn_names);
        %set default CNN
        ind=find(strcmp(default_cnn,cnn_names));
        if ~isempty(ind)
            handles.cnn_name.Value=ind;
        end
    else
        auto_support=false;
    end
    if auto_support==true
        handles.cnn_sgmnt.Enable='on';
        handles.use_gpu.Enable='on';
        handles.use_gpu.Value=default_gpu;
    else
        handles.cnn_sgmnt.Enable='off';
        handles.use_gpu.Enable='off';
        handles.use_gpu.Value=~default_gpu;
    end

    handles.next.Enable='off';
    uiwait
end
% --- Outputs from this function are returned to the command line.
function varargout = gui_getmask_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




% --- Executes on button press in maximize.
function maximize_Callback(hObject, eventdata, handles)
% hObject    handle to maximize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global rgbLab;
global colormap;
figure('units','normalized','outerposition',[0 0 1 1],'Color',[0.3 0.3 0.3])
subaxis(1,2,1,'SpacingVert',0.02,'SpacingHoriz',0.01,'MR',0);
imshow(rgbLab);
subaxis(1,2,2,'SpacingVert',0.02,'SpacingHoriz',0.2,'MR',0.1);
imshow(colormap);

% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FileName;
global PathName;
global mask;
imwrite(uint8(mask),fullfile(PathName,strcat(FileName(1:end-4),'_mask.png')));
handles.status.String='Processing...';
pause(0.3);
handles.status.String='Done!';
pause(0.5);
handles.status.String='';

% --- Executes on button press in cnn_sgmnt.
function cnn_sgmnt_Callback(hObject, eventdata, handles)
% hObject    handle to cnn_sgmnt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global image;
global mask;
global old_mask;
 global score;
 global old_score;
old_mask=mask;
 old_score=score;
gpu_use=handles.use_gpu.Value; %use GPU
%h = msgbox('Processing...');
handles.status.String='Processing...';
handles.maximize.Enable='off';
handles.save.Enable='off';
handles.saveas.Enable='off';
handles.cnn_sgmnt.Enable='off';
handles.add_graph_cut.Enable='off';
handles.add_manually.Enable='off';
handles.undo.Enable='off';
handles.next.Enable='off';

pause(1);
%cnn=cell2mat(handles.cnn_name.String(handles.cnn_name.Value));
%[mask,score]=segm(image,cnn,gpu_use);
[mask,score]=segm(image,gpu_use);
mask=double(mask);
handles.maximize.Enable='on';
handles.save.Enable='on';
handles.saveas.Enable='on';
handles.cnn_sgmnt.Enable='on';
handles.add_graph_cut.Enable='on';
handles.add_manually.Enable='on';
handles.next.Enable='on';
handles.undo.Enable='on';
handles.next.Enable='on';
show_mask_gui(mask, handles);
handles.status.String='Done!';
pause(3);
try
    handles.status.String='';
catch
end


% --- Executes on button press in add_manually.
function add_manually_Callback(hObject, eventdata, handles)
% hObject    handle to add_manually (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mask
global old_mask
global image
 global score
 global old_score
h=figure('units','normalized','outerposition',[0 0 1 1],'Color',[0.3 0.3 0.3]);
BW = roipoly(image);
close (h);
old_mask=mask;
 old_score=score;
%get class
temp=image.*repmat(uint8(BW),[1 1 3]);
out.image=temp;
out.value=100;
handles.output.UserData=out;
gui_getclass();
h = findobj('Tag','getclass');
% if exists (not empty)
if ~isempty(h)
    gdata = guidata(h);
    class=gdata.output.UserData;
    if class~=-10
        mask=mask.*double(~BW)+double(BW).*double(class);
        score=ones(size(score,1),size(score,2));
        show_mask_gui(mask, handles);
       
    end
    out.value=-100;
    handles.output.UserData=out;
    close(h)

    handles.next.Enable='on';
end
% --- Executes on button press in add_graph_cut.
function add_graph_cut_Callback(hObject, eventdata, handles)
% hObject    handle to add_graph_cut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mask
global old_mask
global image
 global score
 global old_score

[sz_h,sz_w, ~] = size(image); %get current height, width, and number of color channels
area=sz_h*sz_w; %get the area of the image
g_I=getGradient(image); %get the gradient
avg_g=(sum(g_I(:))/sqrt(area)); %get the average gradient per pixel
N=round(max(5,25*avg_g)); %the initial number of super-pixels
%Extract superpixels from the given image using [1]
[L,~] = superpixels(image,N); %generate the super-pixels of I
h=figure('units','normalized','outerposition',[0 0 1 1],'Color',[0.3 0.3 0.3]);
imshow(image); title('get samples from the object - press enter to finish','Color', 'w');
hFH = imfreehand('Closed',false);
xy_fg = hFH.getPosition;
while true
    w = waitforbuttonpress;
    switch w
        case 1 % (keyboard press)
            key = get(gcf,'currentcharacter');
            if key == 13 % 13 is the return key
                break
            end
        case 0 % (mouse button click)
            hFH = imfreehand('Closed',false);
            xy_fg = [xy_fg;hFH.getPosition];
    end
end


imshow(image); title('get samples from other objects - press enter to finish','Color', 'w');
hFH = imfreehand('Closed',false);
xy_bg = hFH.getPosition;
while true
    w = waitforbuttonpress;
    switch w
        case 1 % (keyboard press)
            key = get(gcf,'currentcharacter');
            if key == 13 % 13 is the return key
                break
            end
        case 0 % (mouse button click)
            hFH = imfreehand('Closed',false);
            xy_bg = [xy_bg;hFH.getPosition];
    end
end

xy_fg=sub2ind(size(image),xy_fg(:,2),xy_fg(:,1));
xy_bg=sub2ind(size(image),xy_bg(:,2),xy_bg(:,1));
close (h);
BW = lazysnapping(image,L,floor(xy_fg),floor(xy_bg));
old_mask=mask;
 old_score=score;
%get class
temp=image.*repmat(uint8(BW),[1 1 3]);
out.image=temp;
out.value=100;
handles.output.UserData=out;
gui_getclass();
h = findobj('Tag','getclass');
% if exists (not empty)
if ~isempty(h)
    gdata = guidata(h);
    class=gdata.output.UserData;
    if class~=-10
        mask=mask.*double(~BW)+double(BW).*double(class);
         score=ones(size(score,1),size(score,2));
        show_mask_gui(mask, handles);

    end
    out.value=-100;
    handles.output.UserData=out;
    close(h)
    handles.next.Enable='on';
end

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


% --- Executes on button press in saveas.
function saveas_Callback(hObject, eventdata, handles)
% hObject    handle to saveas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global FileName;
global PathName;
global mask;
[fileName,pathName,~] = uiputfile({'*.png'},'Save as',fullfile(PathName,strcat(FileName(1:end-4),'.png')));
if ~isequal(fileName,0)
    imwrite(uint8(mask),fullfile(pathName,fileName));
    handles.status.String='Processing...';
    pause(0.3);
    handles.status.String='Done!';
    pause(0.5);
    handles.status.String='';
end


% --- Executes on button press in next.
function next_Callback(hObject, eventdata, handles)
% hObject    handle to next (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mask;
global score;
out.mask=mask; out.score=score;
handles.output.UserData=out;
uiresume


% --- Executes on button press in undo.
function undo_Callback(hObject, eventdata, handles)
% hObject    handle to undo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global mask
global old_mask
global score
global old_score
temp=mask; temp2=score;
mask=old_mask; score=old_score;
old_mask=temp; old_score=temp2;
show_mask_gui(mask, handles);

% --- Executes during object creation, after setting all properties.
function semanticMask_CreateFcn(hObject, eventdata, handles)
% hObject    handle to semanticMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in cnn_name.
function cnn_name_Callback(hObject, eventdata, handles)
% hObject    handle to cnn_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cnn_name contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cnn_name


% --- Executes during object creation, after setting all properties.
function cnn_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cnn_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in use_gpu.
function use_gpu_Callback(hObject, eventdata, handles)
% hObject    handle to use_gpu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global default_gpu;
default_gpu=handles.use_gpu.Value;





% --- Executes when user attempts to close semanticMask.
function semanticMask_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to semanticMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global image;
returnedObj.mask = zeros(size(image,1),size(image,2));
returnedObj.score = zeros(size(image,1),size(image,2));
handles.output.UserData=returnedObj;
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

% Hint: delete(hObject) closes the figure


% --- Executes during object deletion, before destroying properties.
function status_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%Reference:
%[1] Radhakrishna Achanta, Appu Shaji, Kevin Smith, Aurelien Lucchi, Pascal
%Fua, and Sabine Susstrunk, SLIC Superpixels Compared to State-of-the-art
%Superpixel Methods. IEEE Transactions on Pattern Analysis and Machine
%Intelligence, Volume 34, Issue 11, pp. 2274-2282, May 2012
