function [ path ] = batch2path( batchN, n )
%BATCHTOPATH Creates the path from a batch number and a size
%   Trivial

path = strcat('kinect_batch', num2str(batchN), '/kinect', num2str(n), '.ply');

end
