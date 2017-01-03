function [ ptCloudOut ] = flip_pc( ptCloudIn )
%FLIP_POINT_CLOUD Flips the point cloud
%   Flips the input point cloud to take into account the structured-light
%   system's coordinate system

loc = ptCloudIn.Location;

loc(:,2) = -loc(:,2);
loc(:,3) = -loc(:,3);

ptCloudOut = pointCloud(loc);

end
