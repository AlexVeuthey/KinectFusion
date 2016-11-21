function [ batch ] = batch2cell( batchN, offset, size )
%BATCH2STRUCT Creates a cell "batch" from a batch number batchN and
%size
%   Detailed explanation goes here

batch = cell(size, 1);

basePath = strcat('data/kinect_batch', int2str(batchN), '/kinect');

for i = offset:offset+size
    path = strcat(basePath, int2str(i), '.ply');
    batch{i-offset+1} = pcread(path);
end

end
