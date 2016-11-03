function [ transforms, fusedFrames ] = fuseFrames( batch, downsampleRate, gridStep )
%POSE_ESTIMATION Summary of this function goes here
%   Aligns the point clouds from the "batch" array to the first element of
%   the array.

%   This uses the paper's implementation (i.e. using all of the data up to
%   time t, instead of only using the last frame).

% VARIABLES declarations
metric = 'pointToPlane';

size = length(batch);

transforms = cell(size-1,1);

% DOWNSAMPLE for easier alignment
downsampledFirstFrame = pcdownsample(batch{1}, 'random', downsampleRate);
downsampledSecondFrame = pcdownsample(batch{2}, 'random', downsampleRate);

% ALIGN, TRANSFORM and MERGE for the first two frames
transforms{1} = alignPointClouds(downsampledSecondFrame, downsampledFirstFrame, metric);
alignedNewFrame = pctransform(batch{2}, transforms{1});
fusedFrames = pcmerge(batch{1}, alignedNewFrame, gridStep);

for i = 2:size
    newFrame = batch{i};
    
    % DOWNSAMPLE for easier alignment
    downsampledNewFrame = pcdownsample(newFrame, 'random', downsampleRate);
    
    % ALIGN, TRANSFORM and MERGE for new frame and old data
    transforms{i} = alignPointClouds(downsampledNewFrame, pcdownsample(fusedFrames, 'random', downsampleRate*(1/2*i)), metric);
    alignedNewFrame = pctransform(newFrame, transforms{i});
    fusedFrames = pcmerge(fusedFrames, alignedNewFrame, gridStep);
end

end
