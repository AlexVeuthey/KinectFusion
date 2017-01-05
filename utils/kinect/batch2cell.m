function [ batch ] = batch2cell( batchN, size, offset )
%BATCH2CELL Creates a cell "batch" of Kinect depth frames
%   Trivial

if nargin < 3
    offset = 1;
end

batch = cell(size, 1);

basePath = strcat('data/kinect_translate/kinect_batch', int2str(batchN), '/kinect');

for i = offset:offset+size-1
    path = strcat(basePath, int2str(i), '.ply');
    batch{i-offset+1} = pcread(path);
end

end
