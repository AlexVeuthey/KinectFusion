function [ transform, fusedFrame ] = fuseFrames( newFrame, oldFrame, downsampleRate, metric, gridStep, step )
%FUSE_FRAMES Aligns the new frame to the data
%   "metric" variable can be either 'pointToPlane' or 'pointToPoint'. Don't
%   input the step argument if only fusing two frames

% if the step argument is not present, or if the value of step is 2
% (meaning that we are currently fusing the first two frames of a batch),
% then we do not need to apply the increasing downsampling formula.
if nargin < 6
    step = 1/2;
end
if step < 3
    step = 1/2;
end

downsampledNewFrame = pcdownsample(newFrame, 'random', downsampleRate);
downsampledOldFrame = pcdownsample(oldFrame, 'random', downsampleRate*(1/2*step));

transform = pcregrigid(downsampledNewFrame, downsampledOldFrame, 'Metric', metric);
alignedNewFrame = pctransform(newFrame, transform);
fusedFrame = pcmerge(oldFrame, alignedNewFrame, gridStep);

end
