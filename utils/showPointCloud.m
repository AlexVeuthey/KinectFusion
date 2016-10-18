function [  ] = showPointCloud( ptCloud )
%SHOWPOINTCLOUD Summary of this function goes here
%   Detailed explanation goes here

figure
pcshow(ptCloud);
xlabel('X');
ylabel('Y');
zlabel('Z');

end
