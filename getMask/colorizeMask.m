function [rgbM,colormap] = colorizeMask( M )

load('color150.mat');
load('objectName150.mat');
rgbM = colorEncode_(M, colors);
colormap = colorMap_(M, objectNames);
end

