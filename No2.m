function varargout = No2(varargin)
% NO2 MATLAB code for No2.fig
%      NO2, by itself, creates a new NO2 or raises the existing
%      singleton*.
%
%      H = NO2 returns the handle to a new NO2 or the handle to
%      the existing singleton*.
%
%      NO2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NO2.M with the given input arguments.
%
%      NO2('Property','Value',...) creates a new NO2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before No2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to No2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help No2

% Last Modified by GUIDE v2.5 26-Jun-2021 08:34:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @No2_OpeningFcn, ...
                   'gui_OutputFcn',  @No2_OutputFcn, ...
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


% --- Executes just before No2 is made visible.
function No2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to No2 (see VARARGIN)

% Choose default command line output for No2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes No2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = No2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in tampil.
function tampil_Callback(hObject, eventdata, handles)
% hObject    handle to tampil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename="DATA RUMAH.xlsx";
opts = detectImportOptions(filename);
opts.SelectedVariableNames = [1 3:8];%memberikan range kolom
kumpul=readmatrix(filename,opts);%membaca file secara matrix
set(handles.tabel,'Data',kumpul);%meletakkan matrix ke dalam uitable


% --- Executes on button press in proses.
function proses_Callback(hObject, eventdata, handles)
% hObject    handle to proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename="DATA RUMAH.xlsx";
opts = detectImportOptions(filename);
opts.SelectedVariableNames = [3:8];%memberikan range kolom
data=readmatrix(filename,opts);%membaca file secara matrix
w=[0.3,0.2,0.23,0.1,0.07,0.1];%menentukan bobot setiap kriteria
k=[0,1,1,1,1,1];%menentukan atribut apakah dia biaya atau benefit

%tahapan 1. normalisasi matriks
[m n]=size(data);%matriks m data n dengan ukuran sebanyak variabel data 
R=zeros(m,n);%membuat matriks R, yang merupakan matriks kosong
Y=zeros(m,n);%membuat matriks Y, yang merupakan titik kosong
for j=1:n
    if k(j)==1%statement untuk kriteria dengan atribut keuntungan
        R(:,j)=data(:,j)./max(data(:,j));
    else
        R(:,j)=min(data(:,j))./data(:,j);
    end
end
%tahapan kedua, proses perangkingan
for i=1:m
 V(i)= sum(w.*R(i,:))
end
[dat no]=sort(V,'descend');%proses pengurutan V dari yang terbesar
hasil=[no(1:20);dat(1:20)];%memasukan hasil soring ke dalam matrix dangan memberikan range 1-20
hasil=transpose(hasil);%melakukan transpose matix hasil
set(handles.tabel1,'Data',hasil);%menampilkan data di tabel
