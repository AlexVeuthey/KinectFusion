function [ ptCloudOut ] = fuse_pc( ptCloudL, ptCloudR )
%FUSE_PC Trivial fusion of two point clouds without box grid filter.
%   Extract the points and concatenate them

locA = ptCloudL.Location;
locB = ptCloudR.Location;

loc = cat(1, locA, locB);

ptCloudOut = pointCloud(loc);

end
