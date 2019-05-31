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


function out = getMasks(mask, show)
%getMasks: return the encoded masks from a given mask image. The output is
%a structure whose elements are out.mask and out.class. 
%Input: 
%- mask: grayscale image that contains the mask. The mask contains values
%from 1-150 that refers to the corresponding object per pixel. The values
%are based on objectName150.mat file. 
%- show: show=1 -> visualize the mask in rgb with labels. show=0 (default)
load('objectName150.mat');
if nargin<1
    error('Wrong number of input arguments');
elseif nargin<2
    show=0;
end

if size(mask,3)==3
    mask=mask(:,:,1);
end

codes=setdiff(unique(mask),0);
count=1;
for i=1:length(codes)
    m=(mask==codes(i));
    out(count).mask=uint8(m);
    out(count).class=cell2mat(objectNames(codes(i)));
    out(count).code=codes(i);
    count=count+1;
end

if show==1
    % load pre-defined colors 
    load('color150.mat');
        % color encoding
    rgbMask = colorEncode_(mask, colors);
    % colormaps
    colormap = colorMap_(mask, objectNames);
    figure;
    subplot(121);
    imshow(colormap); title('Colormap');
    subplot(122);
    imshow(rgbMask); title('Prediction-color');
end

