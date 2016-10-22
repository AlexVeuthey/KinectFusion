function [ path ] = batchAndNumberToPath( batchN, n )
%BATCHTOPATH Summary of this function goes here
%   Detailed explanation goes here

path = strcat('kinect_batch', num2str(batchN), '/kinect', num2str(n), '.ply');

end
