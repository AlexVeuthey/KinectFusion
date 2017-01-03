function [ ptCloudOut ] = flip_point_cloud( ptCloudIn )
%FLIP_POINT_CLOUD Summary of this function goes here
%   Detailed explanation goes here

loc = ptCloudIn.Location;

loc(:,2) = -loc(:,2);
loc(:,3) = -loc(:,3);

ptCloudOut = pointCloud(loc);

end
