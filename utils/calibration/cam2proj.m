function [ ptCloudOut ] = cam2proj( ptCloudIn, R, T )
%CAM2PROJ Summary of this function goes here
%   Detailed explanation goes here

locationsCam = ptCloudIn.Location;

num_points = size(locationsCam);

T2 = repmat(T, [1, num_points(1)]);
L2 = locationsCam';

locationsProj  = (R * L2) + T2;

ptCloudOut = pointCloud(locationsProj');

end
