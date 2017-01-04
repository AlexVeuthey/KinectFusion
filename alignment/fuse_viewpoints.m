function [ transform, fused_pc ] = fuse_viewpoints( moving, fixed, merge )
%FUSE_VIEWPOINTS Summary of this function goes here
%   Detailed explanation goes here

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
