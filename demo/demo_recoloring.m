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


%% Recoloring demo
close all
clear;


resizing = 1; %to resize any large image to have maximum dimension = 800

input_images_dir = 'input_images'; %input images directory
output_images_dir = 'recolored_images'; %output images directory
output_masks_dir = 'output_masks'; %output mask directory

if exist(output_images_dir,'dir') == 0
    mkdir(output_images_dir);
end

if exist(output_masks_dir,'dir') == 0
    mkdir(output_masks_dir);
end

load('objectName150.mat');
load('color150.mat');

bestCandidates = 15; %should be <20

%Recoloring demo
files = dir(fullfile(input_images_dir,'*.jpg'));
for f = 1 : length(files)
    imageName = files(f).name;
    disp('Loading the image...');
    I = imread(fullfile(input_images_dir,imageName));
    %resizing if required
    if resizing == 1
        if size(I,1)*size(I,2) > 800 * 800
            I=imresize(I,800/max(size(I,1),size(I,2)));
            fprintf('Warning: the image size is too large, so we resized it to %d x %d... \n', size(I,1),size(I,2));
        end
    end
    
    disp('Getting the semantic mask...');
    [M, ~, ~]=segm(I);
    
    disp('Recoloring image...');
    out_images = image_recoloring( I, M, bestCandidates);
    disp('Done!');
    
    N = size(out_images,4);
    for i=1:N
        imwrite(out_images(:,:,:,i),fullfile(output_images_dir,strrep(imageName,'.jpg',sprintf('_%02d.jpg',i))));
    end
    imwrite(M,fullfile(output_masks_dir,strrep(imageName,'.jpg','.png')));
    rgbMask = colorEncode_(M, colors);
    imwrite(rgbMask,fullfile(output_masks_dir,strrep(imageName,'.jpg','_rgb.png')));
    colormap = colorMap_(M, objectNames);
    imwrite(colormap,fullfile(output_masks_dir,strrep(imageName,'.jpg','_colorMap.png')));
end

