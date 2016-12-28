function [  ] = showpc( ptCloud, downsamplingRate )
%SHOWPOINTCLOUD Summary of this function goes here
%   Detailed explanation goes here

if nargin < 2
    downsamplingRate = 1;
end

ptCloud = pcdownsample(ptCloud, 'random', downsamplingRate);

figure
pcshow(ptCloud);
xlabel('X');
ylabel('Y');
zlabel('Z');

end
