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


function H=get_hist(IM, bin)
if nargin == 1
    bin = 256;
end
IM = IM * 255;
B = bin;
Q = 256/B;
IM(IM(:,1)>255,1)=255; IM(IM(:,2)>255,2)=255; IM(IM(:,3)>255,3)=255;
IM(IM(:,1)<0,1)=0; IM(IM(:,2)<0,2)=0; IM(IM(:,3)<0,3)=0;
SI = (floor(double(IM)/Q))+1;

H = zeros(B,B,B);
for i = 1:size(IM,1)                                          
    H(SI(i,1),SI(i,2),SI(i,3)) = H(SI(i,1),SI(i,2),SI(i,3))+1;
end

H = H./sum(H(:));
end