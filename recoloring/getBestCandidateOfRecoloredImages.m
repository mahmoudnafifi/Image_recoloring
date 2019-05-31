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


function out_imgs = getBestCandidateOfRecoloredImages(out_imgs, bestCandidates)

%we select images based on the standard deviation of their color channels
%in the Lab space--images with a and b channels with higher standard 
%deviations are assumed to be more colorful images.

score1 = zeros(size(out_imgs,4),1);

for i = 1 : size(out_imgs,4)
    I_reshaped = reshape(out_imgs(:,:,:,i),[],3);
    lab_out_img = rgb2lab(I_reshaped);
    score1(i) = (std(lab_out_img(:,2))+std(lab_out_img(:,3)))/2;
end
score = score1./sum(score1); %- 0.25 * (outofgamut./sum(outofgamut));
[~,ind] = sort(score,'descend');
if bestCandidates < size(out_imgs,4)
    ind = ind(1:bestCandidates);
end
out_imgs = out_imgs (:,:,:,ind);
end

