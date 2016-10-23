function [ batch ] = batch2cell( batchN, size )
%BATCH2STRUCT Creates a cell "batch" from a batch number batchN and
%size
%   Detailed explanation goes here

batch = cell(size, 1);

basePath = strcat('data/kinect_batch', int2str(batchN), '/kinect');

for i = 1:size
    path = strcat(basePath, int2str(i), '.ply');
    batch{i} = pcread(path);
end

end
