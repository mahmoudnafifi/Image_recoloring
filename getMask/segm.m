function [mask, score, scores]=segm(im, use_gpu)
%segm function: segment the image into objects using: RefineNet
%ref: Lin, Guosheng, et al. "Refinenet: Multi-path refinement networks with
%identity mappings for high-resolution semantic segmentation." arXiv
%preprint arXiv:1611.06612 (2016).

%Input:
%-image: input image (RGB)
%-use_gpu: default 0 (cpu)
%Output:
%-mask: contains number of class per pixel. You have to convert it into
%colors if you want to get similar masks provided in ADE20K dataset.
%(uint8)
%-score: score per pixel of the predicted object. (double)
%-scores: all scores such that, at (x,y) there are 150 scores for all
%objects. Note: there is "other objects" class that is represented in the
%first layer of score2

%usage:
% im=imread('image.jpg');
% [mask, score]=segm(image)


%% 
% to use your own model, please be sure that it was trained on Scene 
% Parsing dataset. Then, adjust this function to call your model. This
% function takes the image as an input and should return the predicted
% semantic mask as output.

if nargin==1
    use_gpu=0;
end
%the following code is provided by Lin, Guosheng, et al. (RefineNet)
addpath('../SS_CNN/refinenet/main/my_utils');
dir_matConvNet='../SS_CNN/refinenet/libs/matconvnet/matlab';
run(fullfile(dir_matConvNet, 'vl_setupnn.m'));
curr_path=pwd;
cd ('../SS_CNN/refinenet/main');
run_config=[];
ds_config=[];
if exist('use_gpu', 'var') && use_gpu
    run_config.use_gpu=true;
    run_config.gpu_idx=1;
else
    run_config.use_gpu=false;
end
if ~exist('../temp','dir')
    mkdir('../temp');
else
    
    dinfo = dir(fullfile('../temp','*.txt'));
    for K = 1 : length(dinfo)
        thisfile = fullfile('../temp', dinfo(K).name);
        delete(thisfile);
    end
end

imwrite(im,'../temp/temp.png');
% result dir:
result_dir='../temp';
result_name='temp';
% the folder that contains testing images:
ds_config.img_data_dir='../temp';
% using a trained model
run_config.trained_model_path='../model_trained/refinenet_res152_ade.mat';
ds_config.class_info=gen_class_info_ade();
% for trained model, control the size of input images
run_config.input_img_short_edge_min=450;
run_config.input_img_short_edge_max=800;
% set the input image scales, useful for multi-scale evaluation
% e.g. using multiple scale settings (1.0 0.8 0.6) and average the resulting score maps.
run_config.input_img_scale=0.8;
run_config.gen_net_opts_fn=@gen_net_opts_model_type1;
run_config.run_evaonly=true;
ds_config.use_custom_data=true;
ds_config.use_dummy_gt=true;
run_config.use_dummy_gt=ds_config.use_dummy_gt;
ds_config.ds_name='tmp_data';
run_config.root_cache_dir=result_dir;
mkdir_notexist(run_config.root_cache_dir);
run_config.model_name=result_name;
run_dir_name=fileparts(mfilename('fullpath'));
[~, run_dir_name]=fileparts(run_dir_name);
run_config.run_dir_name=run_dir_name;
run_config.run_file_name=mfilename();
ds_info=gen_dataset_info(ds_config);
train_opts=run_config.gen_net_opts_fn(run_config, ds_info.class_info);
imdb=my_gen_imdb(train_opts, ds_info);
data_norm_info=[];
data_norm_info.image_mean=128;
imdb.ref.data_norm_info=data_norm_info;
if run_config.use_gpu
    gpu_num=gpuDeviceCount;
    if gpu_num>=1
        gpuDevice(run_config.gpu_idx);
    else
        error('no gpu found!');
    end
end
[net_config, net_exp_info]=prepare_running_model(train_opts);
my_net_tool(train_opts, imdb, net_config, net_exp_info);
load('../temp/predict_result_full/temp.mat');
mask=data_obj.mask_data;
scores=gather(double(data_obj.score_map));
[score, ~] = max(scores,[],3);
score = imresize(score,  [data_obj.img_size(1),...
    data_obj.img_size(2)], 'nearest');
cd (curr_path);
return;


