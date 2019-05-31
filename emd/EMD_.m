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


function [ d,f ] = EMD_( arg1,arg2,arg3,arg4, arg5 )
%EMD_ function: calculate the earth mover distance between:
%   - two data points:
%       -arg1=data point1.features
%       -arg2=data point2.features
%       -arg3=data point1.weights
%       -arg4=data point2.weights
%   - data point and an array of data points:
%       -arg1=data point1.features
%       -arg2=array of features
%       -arg3=data point1.weights
%       -arg4=array of weights
%       -arg5= size of the array
%   - data point and an array of data points:
%       -arg1=array of features
%       -arg2=array of weights
%       -arg3= size of the array
%       -arg4= size of each data point (number of features per data point)
%
%   In the second and third options, we assume that all data points have
%   the same number of features and weights
%
%Output:
%  In second and third options (see the discribtion above):
%   d = distances and f is an empty array.
%  In the first option, d and f are:
%  d(1) = EMD, d(2) = flowSize
%  f (flowSize*3) matrix. Each row contains [from, to, amount of work]
%

% %Examples:
% f1 = [[100,40,22]; [211,20,2]; [32,190,150] ];
% f2 = [ [0,0,0]; [50,100,80]; [255,255,255]];
% f3 = [ [50,10,0]; [50,10,40]; [25,55,255]];
%
% F=[f2;f1;f3];
%
% w1 = [ 0.4, 0.3, 0.2 ];
% w2 = [ 0.5, 0.3, 0.2 ];
% w3 = [ 0.2, 0.1, 0.2 ];
%
% W=[w2;w1;w3];
%
% size=length(W);
% size2=length(w1); %size of a distribution
%
% %%%%%%%% Call EMD_ %%%%%%%%%%
% %%option 1
%  [d,f]= EMD_(f1,f2,w1,w2);
% %here you can use different size of features and weights
% %here you recieve d (distance) and f (flow)
% % d(1) = EMD, d(2) = flowSize
% % f (flowSize*3) matrix. Each row contains [from, to, amount of work]
%
%
% %%option 2
% d=EMD_(f1,F,w1,W,size);
%
% for i=1:size
%     disp(sprintf('emd %d = %f',i,d(i)));
% end
%
% %%option 3
% d=EMD_(F,W,size,size2);
% D=squareform(d) %get distance matrix

if nargin==4
    %its either option 1 or option 3
    if length(arg3)==1 && length(arg4)==1 %option 3
        opt=3;
        f=[]; %there is no f
    else
        opt=1;
    end
elseif nargin==5
    opt=2;
    f=[]; %there is no f
else
    error('Too few input arguments.');
end


switch opt
    case 1
        [d,f]=EMD1(arg1,arg2,arg3,arg4);
    case 2
        d= EMD2(arg1,arg2,arg3,arg4,arg5);
    case 3
        d= EMD3(arg1,arg2,arg3,arg4);
end

end

