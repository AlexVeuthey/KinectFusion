function [ transform ] = alignPointClouds( newFrame, oldData, metric )
%ALIGN_POINT_CLOUDS Aligns the new frame to the data
%   "metric" variable can be either 'pointToPlane' or 'pointToPoint'

transform = pcregrigid(newFrame, oldData, 'Metric', metric);

end
