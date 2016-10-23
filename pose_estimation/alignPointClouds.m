function [ transform, newData ] = alignPointClouds( oldData, newFrame, metric )
%ALIGN_POINT_CLOUDS Aligns the new frame to the data
%   "metric" variable can be either 'pointToPlane' or 'pointToPoint'

[transform, newData] = pcregrigid(oldData, newFrame, 'Metric', metric);

end
