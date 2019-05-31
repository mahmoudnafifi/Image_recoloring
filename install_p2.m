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


function install_p2()

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
% This function will do the last part for you. Be sure that Git is already 
% installed. Be sure also that you already installed Visual Studio 2015 or 
% greater for Windows or GCC 4.8 and LibJPEG for Linux OS (that is required
% to compile Mex files of MatConvNet. For more information, please visit: 
% http://www.vlfeat.org/matconvnet/install/
% Please choose one of the mentioned compilers as the compiler for Mex 
% files based on your OS. To choose a compiler, please use the following 
% Matlab commands: mex -setup C++ and mex -setup C'

%%
% If you want to do the installation manually, please follow the 
% instructions in the ReadMe file

%%
current = pwd;
disp('----------------------------------------------');
disp('Part 5/5 (setup MatConvNet and RefineNet)...');
disp('----------------------------------------------');

disp('Now, you have to install MatConvNet and RefineNet in SS_CNN directory. Be sure that Git is already installed.');


disp('This part requires Visual Studio 2015 or greater for Windows OS or GCC 4.8 and LibJPEG for Linux OS. For more information, please visit: http://www.vlfeat.org/matconvnet/install/');
disp('Please choose one of the mentioned compilers as the compiler for Mex files based on your OS');
disp('To choose a compiler, please use the following Matlab commands: mex -setup C++ and mex -setup C');


prompt =('Continue? [Y/N]:');
str = input(prompt,'s');
while isempty(str)
    str = input(prompt,'s');
end
switch lower(str)
    case 'n'
        return;
    case 'y'
        
        system(sprintf('git clone https://github.com/guosheng/refinenet.git %s', fullfile('SS_CNN','RefineNet')));
        
        disp('Copying required files for RefineNet to MatconvNet...');
        
        bases = fullfile('SS_CNN','RefineNet','main','my_matconvnet_resnet',{'+dagnn',...
            '@DagNN','impl'});
        target_bases = fullfile('SS_CNN','RefineNet','libs','matconvnet','matlab',{'+dagnn',fullfile('+dagnn','@DagNN'),fullfile('src','bits','impl')});
        for b = 1 : length(bases)
            files= dir(fullfile(bases{b},'*.m'));
            if isempty(files)
                files= dir(fullfile(bases{b},'*.cpp')); files = {files(:).name}';
                files_= dir(fullfile(bases{b},'*.cu')); files = [files;{files_(:).name}];
            else
                files = {files(:).name};
            end
            for f = 1 : length(files)
                copyfile(fullfile(bases{b},files{f}),fullfile(target_bases{b},files{f}));
            end
        end
        disp('Required files were copied!');
        
        disp('Compiling ... ');
        
        disp('Start compiling...');
        
        cd (fullfile('SS_CNN','RefineNet','libs','matconvnet'));
        addpath('matlab');
        disp('Compiling MatConvNet for CPU...');
        error = 0;
        try
            vl_compilenn;
            disp('Compilred for CPU.');
        catch
            error =1;
            disp('Error during installing MatConvNet .. please visit http://www.vlfeat.org/matconvnet/install/');
        end
        %disp('Compiling MatConvNet for GPU  ... be sure that CUDA is install');
        %try
        %    vl_compilenn('enableGpu', true);
        %    disp('Compilred for GPU.');
        %catch
        %    disp('Error during installing MatConvNet .. please visit http://www.vlfeat.org/matconvnet/install/');
        %end
        cd(current);

        if error==0
            disp('Installing pre-trained RefineNet model for semantic segmentation...');
            web('https://drive.google.com/uc?export=download&id=1-HDFsWsO-ziSH_ZinwbmRaDgwso8zECv');
            disp('Check your web browser!');
            prompt =('When you finish downloading, please copy and paste the file fullname (for example, C:\\users\\Documents\\refinenet_res152_ade.mat): ');
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
            
            error=1;
            while error == 1
                try
                    movefile(str,fullfile('SS_CNN','RefineNet','model_trained','refinenet_res152_ade.mat'));
                    error = 0;
                catch
                end
            end
            disp('Part 5 is done!'); 
        end
end

