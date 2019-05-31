function colormap = colorMap_(mask, objectnames, bgcolor)
%% This function generates colormaps for visualization
if nargin==2
    bgcolor=1;
end
colormap = cell(2,8);

idxUnique = unique(mask)';
cnt = 0;
for idx = idxUnique
    if idx==0  
        cnt = cnt + 1;
        colormap{cnt} = imread(fullfile('../color150','others.jpg'));
    else
        cnt = cnt + 1;
        colormap{cnt} = imread(fullfile('../color150',[objectnames{idx} '.jpg']));
    end
    
    if cnt>= numel(colormap)
        break; 
    end
end

for i = cnt+1 : numel(colormap)
    colormap{i} = 255 * ones(30, 150, 3, 'uint8') * bgcolor;
end

colormap = cell2mat(colormap');