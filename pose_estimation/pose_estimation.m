function [ transforms, fusedFrames ] = pose_estimation( batch )
%POSE_ESTIMATION Summary of this function goes here
%   Aligns the point clouds from the "batch" array to the first element of
%   the array. This requires the first frame of the array to be captured
%   with the kinect laying on a flat surface, so that the data is aligned
%   correctly.

%   This uses the paper's implementation (i.e. using all of the data up to
%   time t, instead of only using the last frame).

% VARIABLES declarations
metric = 'pointToPlane';

size = length(batch);

transforms = cell(size-1,1);

% DOWNSAMPLE for easier alignment
downsampledFirstFrame = pcdownsample(batch{1}, 'random', 0.05);
downsampledSecondFrame = pcdownsample(batch{2}, 'random', 0.05);

% ALIGN, TRANSFORM and MERGE for the first two frames
transforms{1} = alignPointClouds(downsampledSecondFrame, downsampledFirstFrame, metric);
alignedNewFrame = pctransform(batch{2}, transforms{1});
fusedFrames = pcmerge(batch{1}, alignedNewFrame, 0.001);

for i = 2:size
    newFrame = batch{i};
    
    % DOWNSAMPLE for easier alignment
    downsampledNewFrame = pcdownsample(newFrame, 'random', 0.05);
    
    % ALIGN, TRANSFORM and MERGE for new frame and old data
    transforms{i} = alignPointClouds(downsampledNewFrame, fusedFrames, metric);
    alignedNewFrame = pctransform(newFrame, transforms{i});
    fusedFrames = pcmerge(fusedFrames, alignedNewFrame, 0.001);
end

end
