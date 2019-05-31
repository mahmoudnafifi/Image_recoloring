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


function install_p1

%%
% Our method is a data-driven approach that requires Scene Parsing dataset
% to be installed. Also, our algorithm requires pre-computed files to be
% located in specific directories. These files include the distribution of
% object color distributions (DoD) as explained in the paper. We also rely
% on the earth mover's distance (EMD) to compute the similarity between input
% color palettes and our training color palettes. To do that, we need to
% compile the mex file of EMD. Finally, our algorithm requires an
% object-based semantic segmentation model to run. We use RefineNet in our
% experiments. Accordingly, we require to install and setup MatConvNet and
% RefineNet.
% The installation includes five parts which are:
% 1- Adding paths to Matlab
% 2- Compile EMD mex files
% 3- Downloading Scene Parsing dataset
% 4- Install our pre-computed data (DoDs)
% 5- Install and setup MatConvNet and RefineNet.
% This function will do the first 4 parts for you. Then we need to change
% the C++/C compiler in Matlab to be able to continue to the 5th part.

%%
% If you want to do the installation manually, please follow the
% instructions in the ReadMe file

%%
disp('Installing...')
disp('Be sure that you select MinGW for C++ Mex file compiling. To change it, use the following Matlab command: mex -setup C++');
prompt =('Continue? [Y/N]:');
str = input(prompt,'s');
while isempty(str)
    str = input(prompt,'s');
end
switch lower(str)
    case 'n'
        return;
    case 'y'
        disp('---------------------------');
        disp('Part 1/5 (adding paths)...');
        disp('---------------------------');
        current = pwd;
        addpath([current '/colour-transfer-master']);
        addpath([current '/cp']);
        addpath([current '/emd']);
        addpath([current '/getMask']);
        addpath([current '/recoloring']);
        addpath([current '/general']);
        savepath
        disp('Part 1 is done!');
        
        
        disp('-----------------------------------');
        disp('Part 2/5 (compiling mex files)...');
        disp('-----------------------------------');
        
        
        
        cd ([current,'\emd'])
        mex EMD1.cpp
        mex EMD2.cpp
        mex EMD3.cpp
        cd(current)
        disp('Part 2 is done!');
        
        
        disp('------------------------------------------------');
        disp('Part 3/5 (downloading Scene Parsing dataset)...');
        disp('------------------------------------------------');
        
        outfilename = websave(fullfile('..','ADEChallengeData2016.zip'),'http://data.csail.mit.edu/places/ADEchallenge/ADEChallengeData2016.zip');
        disp('Unzipping it...');
        unzip(fullfile('..','ADEChallengeData2016.zip'),fullfile('..','.'));
        delete(fullfile('..','ADEChallengeData2016.zip'));
        
        disp('Part 3 is done!');
        
        
        disp('--------------------------------------------------------');
        disp('Part 4/5 (downloading our precomputed training data)...');
        disp('--------------------------------------------------------');
        
        web('https://ln.sync.com/dl/d47b76bb0/vshj9d85-gny78wxi-3k2m53mp-943h84k6');
        disp('Check your web browser!');
        prompt =('When you finish downloading, please copy and paste the file fullname (for example, C:\\users\\Documents\\DoD_data.zip): ');
        str = input(prompt,'s');
        while isempty(str)
            str = input(prompt,'s');
        end
        while exist(str,'file')==0
            
            disp('File is not found! Please, be sure that the file is already downloaded and provide a correct file fullname.');
            str = input(prompt,'s');
            while isempty(str)
                str = input(prompt,'s');
            end
        end
        
		if exist(fullfile('..','data'),'dir') == 0
			mkdir(fullfile('..','data'));
		end 
		
        error=1;
        while error == 1
            try
                movefile(str,fullfile('..','data','DoD_data.zip'));
                error = 0;
            catch
            end
        end
        
        
        
        disp('Unzipping it...');
        unzip(fullfile('..','data','DoD_data.zip'),fullfile('..','data','DoD_data'));
        delete(fullfile('..','data','DoD_data.zip'));
        
        disp('Installation of our data is done!');
        
        disp('Part 4 is done!');
        
        disp('Now, please run install_p2 to continue with part 5.');
        
        
end
end