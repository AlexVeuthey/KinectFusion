function [ batch ] = batch2cell( batchN, size, offset )
%BATCH2STRUCT Creates a cell "batch" from a batch number batchN and
%size
%   Detailed explanation goes here

if nargin < 3
    offset = 1;
end

batch = cell(size, 1);

basePath = strcat('data/kinect_batch', int2str(batchN), '/kinect');

for i = offset:offset+size-1
    path = strcat(basePath, int2str(i), '.ply');
    batch{i-offset+1} = pcread(path);
end

end
