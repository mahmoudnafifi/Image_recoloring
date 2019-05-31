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


function [Io,out_of_gamut] = color_transfer(It, II)

try
    Io = real(colour_transfer_MKL(II, It)); % [Pitie07b] in RGB space
catch
    Io = II;
end

Io_reshaped = reshape(Io,[],3);
inds_z = Io_reshaped(:,1)<0 | Io_reshaped(:,2)<0 | Io_reshaped(:,3)<0;
inds_o = Io_reshaped(:,1)>1 | Io_reshaped(:,2)>1 | Io_reshaped(:,3)>1;

out_of_gamut = sum(inds_z) + sum(inds_o);

Io = cat(3,imadjust(Io(:,:,1)),imadjust(Io(:,:,2)),imadjust(Io(:,:,3))); %apply contrast adjustment

end