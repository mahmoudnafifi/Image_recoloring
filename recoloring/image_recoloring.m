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


function out_images = image_recoloring( I, M, bestCandidates)
%% 
% Input:
% - I: input image
% - M: semantic mask
% - bestCandidates: number of recolored images (should be <=20)

clustNum=20; %number of clusters in the DoD

if bestCandidates>clustNum %error if the required number is more than the current number of clusters
    error('Number of candidates should be less than %d\n',clustNum);
end

Bin = 32; %histogram bins

I=im2double(I);

[bestObject,best,objects]=pickBestCandidate(M); %get the primary object (as explained in the paper)

all_objs = [best,objects];

counter = 0;

K=20; %number of colors per palette. We use 20 colors per palette in our experiments

sigma=25; %sigma for color palette extraction

for i = 1 : clustNum %for each cluster in the selected primary object, do
    if exist(fullfile('..','..','data','DoD_data',sprintf('%s_clust_%d.mat',bestObject,i)),'file') ~=0
        counter = counter + 1;
        %if exist, load the corresponding file
        clusters.cluster(counter) = load(...
            fullfile('..','..','data','DoD_data',sprintf('%s_clust_%d.mat',bestObject,i)));
    end
end

N = counter; %the final number of the recolored images (will pick best candidates later)

out_images = zeros(size(I,1), size(I,2), size(I,3), N); %output images will be stored here
out_of_gamut = zeros(N,1); %to count the out-of-gamut pixels in each recolored image

I_reshaped = reshape(I,[],3);

LL = length(unique(all_objs)); %get the object IDs in the current input image (based on the predicted semantic mask)

centers_ = zeros(LL,K,3);
area_ = zeros(LL,K);
        
for ind = 1 : N %for each cluster do
    hist_target = zeros(Bin,Bin,Bin); %target histogram will be stored here
    Tcenters = clusters.cluster(ind).datapoints.centers*255; %load all training color palettes of the current cluster. It will return nx150x20x3 tensor, where n is the total number of training samples included in this cluster. The 150 is the number of semantic objects in the Scene Parsing dataset, and the 20x3 represents the color palette of each training sample.
    Tarea = clusters.cluster(ind).datapoints.area; %load the corresponding areas (total number of object pixels/total number of image pixels) for each sample.
    %normalize the areas
    for k = 1 : size(Tarea,1)
        sum_vec = sum(Tarea(k,:,:),3); sum_vec(sum_vec == 0) = 1;
        Tarea(k,:,:) = Tarea(k,:,:)./sum_vec;
    end
    for i = 1 : LL %for each object, do

        obj = all_objs(i);
        BW=(M==obj); %compute a BW mask for interesting pixels of that object
        ratio  = sum(BW(:))/(size(I,1)*size(I,2)); %ratio to the total number of pixels in the input image
        temp = I_reshaped(BW,:);
        if mod(size(temp,1),2)~=0 %if the number of pixels is not an even number, add a new pixel of mean channels to make it an even number
            temp(end+1,1)=mean(temp(:,1));
            temp(end+1,2)=mean(temp(:,2));
            temp(end+1,3)=mean(temp(:,3));
        end
        img_r=reshape(temp(:,1),2,[]); %reshape to be something x 2
        img_g=reshape(temp(:,2),2,[]);
        img_b=reshape(temp(:,3),2,[]);
        img = cat(3,img_r,img_g,img_b); %concat them to generate a dummy image
        if ind == 1 %if it is the first cluster, compute the color palette for the current object (i) in the input image
        [centers,labels]=extract_theme(img,K,sigma);  %extract its color palette
        area=zeros(K,1);
        %normalize the area
        for kk=1:K
            area(kk)=length(find(labels==kk));
        end
        centers_(i,:,:) = centers;
        area_(i,:) = area;
        else
            centers = reshape(centers_(i,:,:),K,3);
            area = reshape(area_(i,:),K,1);
        end
            
        centers = centers * 255; %Because it is double, make it in the range [0-255] to compute the EMD
        area = area./sum(area);
        Tcenters_obj = reshape(Tcenters(:,obj,:,:),[],20,3); %get all training color palette of this object in the current cluster
        Tarea_obj = reshape(Tarea(:,obj,:),[],20);
        d=EMD2(centers,Tcenters_obj,area,Tarea_obj',size(Tcenters_obj,1)); %compute the EMD between the extracted color palette and all training samples of this object in the current cluster
        Tid = find(d == max(d)); %find the most dissimilar example
        if length(Tid)>1
            Tid = Tid(1);
        end        
        if isempty(Tid)==0 %generate a color histgoram of the training pixels of the most dissimilar example and add it to the target histogram
            targetImg = im2double(imread(...
                clusters.cluster(ind).datapoints.imageNames{Tid})); %get the correspinding training image
            targetMsk = imread(...
                clusters.cluster(ind).datapoints.maskNames{Tid}); %get its semantic mask
        else %if it is empty, add the input color histogram of this object to the target histogram instead.
            hist_target =  hist_target + ratio .* get_hist([I_reshaped(BW,1),I_reshaped(BW,2),I_reshaped(BW,3)], Bin);
            continue; %skip the following steps if there is no training example
        end
        % if we found a training example (the most dissimilar one), we will
        % create its color histogram and add it to the target histogram
        BWT=(targetMsk==obj);
        RT = targetImg(:,:,1); GT = targetImg(:,:,2); BT = targetImg(:,:,3);
        RT = RT(BWT); GT = GT(BWT); BT = BT(BWT);
        hist_target =  hist_target + ratio .* get_hist([RT,GT,BT],Bin);
    end
    hist_target = hist_target./sum(hist_target(:)); %after constructing the target histogram, normalize it
    [out_images(:,:,:,ind),out_of_gamut(ind)]  = transfer_colors(hist_target,I,Bin); %now we have generated a traget histogram, we can use one of color transfer methods to transfer colors of input image to the target histgoram
end
%select best candidate (this part is not mentioned in the paper). We use
%two steps to pick best candidates. The first one is based on out-of-gamut
%pixles. The second one is based on colors diversity of output images.
out_images = out_images(:,:,:,(out_of_gamut./(size(out_images,1)*size(out_images,2))<0.35));  %discard any recolored image that has out-of-gamut pixels more than 35% of the total number of pixels
out_images = getBestCandidateOfRecoloredImages(out_images, bestCandidates); %select the most colorful images
end