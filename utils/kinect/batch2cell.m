function [ batch ] = batch2cell( batchN, path, size, offset )
%BATCH2CELL Creates a cell "batch" of Kinect depth frames
%   Trivial

if nargin < 4
    offset = 1;
end

batch = cell(size, 1);

basePath = strcat(path, int2str(batchN), '/kinect');

for i = offset:offset+size-1
    fullPath = strcat(basePath, int2str(i), '.ply');
    batch{i-offset+1} = pcread(fullPath);
end

end
