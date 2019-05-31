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


%% EMD Demo

%%test emd_

f1 = [[100,40,22]; [211,20,2]; [32,190,150]; [2,100,100]];
f2 = [ [0,4,0]; [50,100,80]; [255,255,255];[255,255,255]];
f3 = [ [0,10,0]; [20,100,80]; [25,255,255];[2,1,10]];

F=[f1;f2;f3];

w1 = [0.4, 0.3, 0.2, 0.1];
w2 = [0.5, 0.3, 0.2 ,0.3];
w3 = [0.1,0.2,0.5,0.2];

W=[w1;w2;w3];


size1=size(W,1);

% %%test EMD1
% [d,f]= EMD1(f1,f2,w1,w2)




%%test emd2
% d=EMD2(f1,F,w1,W',size1);
% for i=1:size1
%     disp(sprintf('emd %d = %f',i,d(i)));
% end



%%test emd3
size2=size(W,2); %size of distribution
d=EMD3(F,W',size1,size2);

D=squareform(d) %get distance matrix
