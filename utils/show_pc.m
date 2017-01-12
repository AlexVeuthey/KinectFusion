function [  ] = show_pc( ptCloud, downsamplingRate )
%SHOWPOINTCLOUD Wrapper for matlab's pcshow, with better axis
%representation and included downsampling
%   Simply downsamples and shows the point cloud

if nargin < 2
    downsamplingRate = 1;
end

ptCloud = pcdownsample(ptCloud, 'random', downsamplingRate);

pcshow(ptCloud, 'verticalAxis', 'Z');
xlabel('X');
ylabel('Y');
zlabel('Z');

end
