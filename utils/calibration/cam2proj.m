function [ ptCloudOut ] = cam2proj( ptCloudIn, R, T )
%CAM2PROJ Transforms the point cloud into projector CS
%   Formula from email

locationsCam = ptCloudIn.Location;

num_points = size(locationsCam);

T2 = repmat(T, [1, num_points(1)]);
L2 = locationsCam';

locationsProj  = (R * L2) + T2;

ptCloudOut = pointCloud(locationsProj');

end
