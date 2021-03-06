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


function objectname=getObjectName(code)
%% objectNames
objectNames={{'wall'},...
    {'building'},...
    {'sky'},...
    {'floor'},...
    {'tree'},...
    {'ceiling'},...
    {'road'},...
    {'bed'},...
    {'windowpane'},...
    {'grass'},...
    {'cabinet'},...
    {'sidewalk'},...
    {'person'},...
    {'earth'},...
    {'door'},...
    {'table'},...
    {'mountain'},...
    {'plant'},...
    {'curtain'},...
    {'chair'},...
    {'car'},...
    {'water'},...
    {'painting'},...
    {'sofa'},...
    {'shelf'},...
    {'house'},...
    {'sea'},...
    {'mirror'},...
    {'rug'},...
    {'field'},...
    {'armchair'},...
    {'seat'},...
    {'fence'},...
    {'desk'},...
    {'rock'},...
    {'wardrobe'},...
    {'lamp'},...
    {'bathtub'},...
    {'railing'},...
    {'cushion'},...
    {'base'},...
    {'box'},...
    {'column'},...
    {'signboard'},...
    {'chest of drawers'},...
    {'counter'},...
    {'sand'},...
    {'sink'},...
    {'skyscraper'},...
    {'fireplace'},...
    {'refrigerator'},...
    {'grandstand'},...
    {'path'},...
    {'stairs'},...
    {'runway'},...
    {'case'},...
    {'pool table'},...
    {'pillow'},...
    {'screen door'},...
    {'stairway'},...
    {'river'},...
    {'bridge'},...
    {'bookcase'},...
    {'blind'},...
    {'coffee table'},...
    {'toilet'},...
    {'flower'},...
    {'book'},...
    {'hill'},...
    {'bench'},...
    {'countertop'},...
    {'stove'},...
    {'palm'},...
    {'kitchen island'},...
    {'computer'},...
    {'swivel chair'},...
    {'boat'},...
    {'bar'},...
    {'arcade machine'},...
    {'hovel'},...
    {'bus'},...
    {'towel'},...
    {'light'},...
    {'truck'},...
    {'tower'},...
    {'chandelier'},...
    {'awning'},...
    {'streetlight'},...
    {'booth'},...
    {'television'},...
    {'airplane'},...
    {'dirt track'},...
    {'apparel'},...
    {'pole'},...
    {'land'},...
    {'bannister'},...
    {'escalator'},...
    {'ottoman'},...
    {'bottle'},...
    {'buffet'},...
    {'poster'},...
    {'stage'},...
    {'van'},...
    {'ship'},...
    {'fountain'},...
    {'conveyer belt'},...
    {'canopy'},...
    {'washer'},...
    {'plaything'},...
    {'swimming pool'},...
    {'stool'},...
    {'barrel'},...
    {'basket'},...
    {'waterfall'},...
    {'tent'},...
    {'bag'},...
    {'minibike'},...
    {'cradle'},...
    {'oven'},...
    {'ball'},...
    {'food'},...
    {'step'},...
    {'tank'},...
    {'trade name'},...
    {'microwave'},...
    {'pot'},...
    {'animal'},...
    {'bicycle'},...
    {'lake'},...
    {'dishwasher'},...
    {'screen'},...
    {'blanket'},...
    {'sculpture'},...
    {'hood'},...
    {'sconce'},...
    {'vase'},...
    {'traffic light'},...
    {'tray'},...
    {'ashcan'},...
    {'fan'},...
    {'pier'},...
    {'crt screen'},...
    {'plate'},...
    {'monitor'},...
    {'bulletin board'},...
    {'shower'},...
    {'radiator'},...
    {'glass'},...
    {'clock'},...
    {'flag'}};
    %% checks
    if code==0
    objectname='others';
    elseif code>length(objectNames)
        error('undefined object!');
    else
        objectname=cell2mat(objectNames{code});
    end
end

