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


function [out,out_of_gamut] = transfer_colors(target,image,bin)

%%create 2D image from each histogram
L = 800*800; %dimenstion of the dummy image
target_img = zeros(L,3);
target = target (:); 
start_t= 1;
inds_target = find(target~=0);

for i = inds_target'
    [R,G,B] = ind2sub([bin,bin,bin],i);
    target_img(start_t: start_t + floor(L*target(i)) -1,1) = R/bin;
    target_img(start_t: start_t + floor(L*target(i)) -1,2) = G/bin;
    target_img(start_t: start_t + floor(L*target(i)) -1,3) = B/bin;
    start_t = start_t + floor(L*target(i));
end

target_img = reshape(target_img(1:L,:),[sqrt(L),sqrt(L),3]);

[out,out_of_gamut] = color_transfer(target_img, image);
 
end
