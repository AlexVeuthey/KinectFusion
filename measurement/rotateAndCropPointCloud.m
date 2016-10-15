function [ outputCloud ] = rotateAndCropPointCloud( inputCloud, axis, theta, roi )
%ROTATEANDCROPPOINTCLOUD Rotates a point cloud along an axis
%   The axes are x=1, y=2, z=3. Input 0 or anything else for no rotation.

if nargin < 4
    roi = [-inf inf
        -inf inf
        -inf inf];
end

rot = [1 0 0 0 
    0 1 0 0 
    0 0 1 0 
    0 0 0 1];
rotInv = [1 0 0 0
    0 1 0 0 
    0 0 1 0 
    0 0 0 1];

if axis == 1 % X-roll
    rot = [1 0 0 0
        0 cos(theta) -sin(theta) 0
        0 sin(theta) cos(theta) 0
        0 0 0 1];
    rotInv = [1 0 0 0
        0 cos(-theta) -sin(-theta) 0
        0 sin(-theta) cos(-theta) 0
        0 0 0 1];
elseif axis == 2 % Y-roll
    rot = [cos(theta) 0 sin(theta) 0
        0 1 0 0
        -sin(theta) 0 cos(theta) 0
        0 0 0 1];
    rotInv = [cos(-theta) 0 sin(-theta) 0
        0 1 0 0
        -sin(-theta) 0 cos(-theta) 0
        0 0 0 1];
elseif axis == 3 % Z-roll
    rot = [cos(theta) -sin(theta) 0 0
        sin(theta) cos(theta) 0 0 
        0 0 1 0
        0 0 0 1];
    rotInv = [cos(-theta) -sin(-theta) 0 0
        sin(-theta) cos(-theta) 0 0 
        0 0 1 0
        0 0 0 1];
end

transform = affine3d(rot);
outputCloud = pctransform(inputCloud,transform);

ind = findPointsInROI(outputCloud, roi);

outputCloud = select(outputCloud, ind);

transform = affine3d(rotInv);
outputCloud = pctransform(outputCloud,transform);

end
