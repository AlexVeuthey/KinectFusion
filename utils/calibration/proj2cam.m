function [ ptCloudOut ] = proj2cam( ptCloudIn, R, T )
%PROJ2CAM Summary of this function goes here
%   Detailed explanation goes here

locationsProj = ptCloudIn.Location;

num_points = size(locationsProj);

T2 = repmat(T, [1, num_points(1)]);
L2 = locationsProj';

locationsCam  = R \ (L2 - T2);

ptCloudOut = pointCloud(locationsCam');

end
