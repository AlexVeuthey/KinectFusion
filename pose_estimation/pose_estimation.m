function [ transforms, newData ] = pose_estimation( batch )
%POSE_ESTIMATION Summary of this function goes here
%   Aligns the point clouds from the "batch" array to the first element of
%   the array. This requires the first frame of the array to be captured
%   with the kinect laying on a flat surface, so that the data is aligned
%   correctly.

%   This uses the paper's implementation (i.e. using all of the data up to
%   time t, instead of only using the last frame).

metric = 'pointToPlane';

size = length(batch);

transforms = cell(size,1);

[transforms{1}, newData] = alignPointClouds(batch{1}, batch{2}, metric);

for i = 2:size
    [transforms{i}, newData] = alignPointClouds(newData, batch{i}, metric);
end

end
