function [ transform, fused_pc ] = fuse_viewpoints( moving, fixed, merge, gridStep )
%FUSE_VIEWPOINTS Simple wrapper for pcregrigid with automatic merging
%   The inlier ratio is very important for a correct fusion! 0.5 to 0.8
%   gives good results.
%   The third argument is meant for selection between trivial fusion or
%   using pcmerge from matlab (with box grid filter).

if nargin < 4
    gridStep = 0.01;
end

movingD = pcdownsample(moving, 'gridAverage', 1);
fixedD = pcdownsample(fixed, 'gridAverage', 1);

transform = pcregrigid(movingD, fixedD, 'Metric', 'pointToPlane', 'InlierRatio', 0.5, 'Extrapolate', true);

movingAligned = pctransform(moving, transform);

if merge == 1
    fused_pc = pcmerge(fixed, movingAligned, gridStep);
elseif merge == 0
    fused_pc = fuse_pc(fixed, movingAligned);
end

end
