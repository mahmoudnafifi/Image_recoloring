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

% Last Modified by GUIDE v2.5 20-Aug-2017 11:43:17

function varargout = gui_getclass(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_getclass_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_getclass_OutputFcn, ...
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

% --- Executes just before gui_getclass is made visible.
function gui_getclass_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui_getclass (see VARARGIN)

handles.output = hObject;

guidata(hObject, handles);

 % get the handle of mask gui
 handles.confirm.Enable='off';
 h = findobj('Tag','semanticMask');
 if length(h)>1
     h=h(1);
 end
 % if exists (not empty)
 if ~isempty(h)
    % get handles and other user-defined data associated to Gui1
    gdata = guidata(h);
    image=gdata.output.UserData.image;
    axes(handles.mask);
    imshow(image);
    uiwait
 end

 
 
% --- Outputs from this function are returned to the command line.
function varargout = gui_getclass_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

varargout{1} = handles.output;


% --- Executes on button press in wall.
function wall_Callback(hObject, eventdata, handles)
% hObject    handle to wall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

 
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton22.
function pushbutton22_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton23.
function pushbutton23_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton24.
function pushbutton24_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton25.
function pushbutton25_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton25 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton27.
function pushbutton27_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton27 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton28.
function pushbutton28_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton28 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton29.
function pushbutton29_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton31.
function pushbutton31_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton32.
function pushbutton32_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton33.
function pushbutton33_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton34.
function pushbutton34_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton35.
function pushbutton35_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton36.
function pushbutton36_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton37.
function pushbutton37_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton38.
function pushbutton38_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton38 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton39.
function pushbutton39_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton40.
function pushbutton40_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton41.
function pushbutton41_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton42.
function pushbutton42_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton43.
function pushbutton43_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton44.
function pushbutton44_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton45.
function pushbutton45_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton46.
function pushbutton46_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton53.
function pushbutton53_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton53 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton54.
function pushbutton54_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton54 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton55.
function pushbutton55_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton55 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton56.
function pushbutton56_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton56 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton57.
function pushbutton57_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton57 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton58.
function pushbutton58_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton58 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton59.
function pushbutton59_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton59 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton60.
function pushbutton60_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton60 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton61.
function pushbutton61_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton61 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton62.
function pushbutton62_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton62 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton63.
function pushbutton63_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton63 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton64.
function pushbutton64_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton64 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton65.
function pushbutton65_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton65 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton66.
function pushbutton66_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton66 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton67.
function pushbutton67_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton67 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton68.
function pushbutton68_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton68 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton69.
function pushbutton69_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton69 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton70.
function pushbutton70_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton70 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton71.
function pushbutton71_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton71 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton72.
function pushbutton72_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton72 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton73.
function pushbutton73_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton73 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton74.
function pushbutton74_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton74 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton75.
function pushbutton75_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton75 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton76.
function pushbutton76_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton76 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton77.
function pushbutton77_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton77 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton78.
function pushbutton78_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton78 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton79.
function pushbutton79_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton79 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton80.
function pushbutton80_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton80 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton81.
function pushbutton81_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton81 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton82.
function pushbutton82_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton82 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton83.
function pushbutton83_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton83 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton84.
function pushbutton84_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton84 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton85.
function pushbutton85_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton85 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton86.
function pushbutton86_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton86 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton87.
function pushbutton87_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton87 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton88.
function pushbutton88_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton88 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton89.
function pushbutton89_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton89 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton90.
function pushbutton90_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton90 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton91.
function pushbutton91_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton91 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton92.
function pushbutton92_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton92 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton93.
function pushbutton93_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton93 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton94.
function pushbutton94_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton94 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton102.
function pushbutton102_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton102 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton104.
function pushbutton104_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton104 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton105.
function pushbutton105_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton105 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton107.
function pushbutton107_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton107 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton108.
function pushbutton108_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton108 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton109.
function pushbutton109_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton109 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton111.
function pushbutton111_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton111 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton112.
function pushbutton112_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton112 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton113.
function pushbutton113_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton113 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton115.
function pushbutton115_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton115 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton116.
function pushbutton116_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton116 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton117.
function pushbutton117_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton117 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton119.
function pushbutton119_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton119 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton120.
function pushbutton120_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton120 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton121.
function pushbutton121_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton121 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton123.
function pushbutton123_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton123 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton124.
function pushbutton124_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton124 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton125.
function pushbutton125_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton125 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton127.
function pushbutton127_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton127 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton128.
function pushbutton128_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton128 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton129.
function pushbutton129_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton129 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton131.
function pushbutton131_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton131 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton132.
function pushbutton132_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton132 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton133.
function pushbutton133_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton133 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton135.
function pushbutton135_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton135 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton136.
function pushbutton136_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton136 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton137.
function pushbutton137_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton137 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton139.
function pushbutton139_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton139 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton140.
function pushbutton140_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton140 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton141.
function pushbutton141_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton141 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton143.
function pushbutton143_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton143 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton144.
function pushbutton144_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton144 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;


global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;
% --- Executes on button press in pushbutton145.
function pushbutton145_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton145 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton147.
function pushbutton147_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton147 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton148.
function pushbutton148_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton148 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton149.
function pushbutton149_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton149 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton151.
function pushbutton151_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton151 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton152.
function pushbutton152_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton152 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton153.
function pushbutton153_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton153 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton154.
function pushbutton154_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton154 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton155.
function pushbutton155_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton155 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton156.
function pushbutton156_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton156 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton157.
function pushbutton157_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton157 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton158.
function pushbutton158_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton158 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton159.
function pushbutton159_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton159 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton160.
function pushbutton160_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton160 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton162.
function pushbutton162_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton162 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton163.
function pushbutton163_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton163 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton164.
function pushbutton164_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton164 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton165.
function pushbutton165_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton165 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton166.
function pushbutton166_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton166 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton167.
function pushbutton167_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton167 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton168.
function pushbutton168_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton168 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton169.
function pushbutton169_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton169 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton174.
function pushbutton174_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton174 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton175.
function pushbutton175_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton175 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton176.
function pushbutton176_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton176 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton177.
function pushbutton177_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton177 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton178.
function pushbutton178_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton178 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton179.
function pushbutton179_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton179 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton180.
function pushbutton180_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton180 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton181.
function pushbutton181_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton181 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton182.
function pushbutton182_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton182 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton183.
function pushbutton183_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton183 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton185.
function pushbutton185_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton185 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton186.
function pushbutton186_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton186 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton187.
function pushbutton187_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton187 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton192.
function pushbutton192_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton192 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;

% --- Executes on button press in pushbutton193.
function pushbutton193_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton193 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;



% --- Executes on button press in confirm.
function confirm_Callback(hObject, eventdata, handles)
% hObject    handle to confirm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
handles.output.UserData=getObjectNumber(objName);
uiresume


% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output.UserData=-10;
uiresume


% --- Executes on button press in pushbutton194.
function pushbutton194_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton194 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
objName = get(hObject,'String'); handles.confirm.Enable='on'; handles.class_name.String=objName;


% --- Executes when user attempts to close getclass.
function getclass_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to getclass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global objName;
handles.output.UserData=-10;
h = findobj('Tag','semanticMask');
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


% --- Executes during object creation, after setting all properties.
function getclass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to getclass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
