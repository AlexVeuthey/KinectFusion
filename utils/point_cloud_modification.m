addpath(genpath('data'));

figN = 1;

ROI_ALL = [-inf inf
    -inf inf
    -inf inf];

bunny = pcread('bun_zipper.ply');

% rotate the bunny so as to have its bottom on the bottom...
rot = [1 0 0 0 
    0 cos(3*pi/2) -sin(3*pi/2) 0
    0 sin(3*pi/2) cos(3*pi/2) 0
    0 0 0 1];

transform = affine3d(rot);
bunny = pctransform(bunny,transform);

% displaying the original bunny
% figure(figN)
% figN = figN+1;
% pcshow(bunny); xlabel('X'); ylabel('Y'); zlabel('Z');

% defines the Region Of Interest (ROI) where we want to keep the points
roiF = [-1.00 1.00
    -0.15 -0.01
    -1.00 1.00];

roiR = [-0.04 1.00
    -1.00 1.00
    -1.00 1.00];

bunnyR = rotateAndCropPointCloud( bunny, 2, pi/6, roiR );
bunnyF = rotateAndCropPointCloud( bunny, 1, pi/12, roiF);

% figure(figN)
% figN = figN+1;
% pcshow(bunnyR); xlabel('X'); ylabel('Y'); zlabel('Z');
% 
% pcwrite(bunnyF, 'bunnyF.ply');
% pcwrite(bunnyR, 'bunnyR.ply');
