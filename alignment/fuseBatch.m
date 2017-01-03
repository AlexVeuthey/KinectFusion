function [ transforms, fusedFrames ] = fuseBatch( batch, downsampleRate, gridStep )
%POSE_ESTIMATION Summary of this function goes here
%   Aligns the point clouds from the "batch" array to the first element of
%   the array.

%   This uses the paper's implementation (i.e. using all of the data up to
%   time t, instead of only using the last frame).

% VARIABLES declarations
metric = 'pointToPlane';

size = length(batch);

transforms = cell(size-1,1);

% need to fuse the first two frames outside of the main loop
[transforms{1}, fusedFrames] = fuseFrames(batch{2}, batch{1}, downsampleRate, metric, gridStep, 1);

for i = 2:size
    newFrame = batch{i};
    
    % ALIGN, TRANSFORM and MERGE for new frame and old data
    [transforms{i}, fusedFrames] = fuseFrames(newFrame, fusedFrames, downsampleRate, metric, gridStep, i);
end

end
