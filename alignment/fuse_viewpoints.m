function [ transform, fused_pc ] = fuse_viewpoints( moving, fixed, merge )
%FUSE_VIEWPOINTS Simple wrapper for pcregrigid with automatic merging
%   The inlier ratio is very important for a correct fusion! 0.5 to 0.8
%   gives good results.

movingD = pcdownsample(moving, 'gridAverage', 1);
fixedD = pcdownsample(fixed, 'gridAverage', 1);

transform = pcregrigid(movingD, fixedD, 'Metric', 'pointToPlane', 'InlierRatio', 0.7, 'Extrapolate', true);

movingAligned = pctransform(moving, transform);

if merge == 1
    fused_pc = pcmerge(fixed, movingAligned, 0.001);
elseif merge == 0
    fused_pc = fuse_pc(fixed, movingAligned);
end

end
