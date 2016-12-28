%% PATH GENERATION AND UTILS

% This section will setup Matlab to work with the folder architecture used.

clear;
clc;

addpath(genpath('pose_estimation'));
addpath(genpath('measurement'));

addpath(genpath('utils'));
addpath(genpath('data'));

%% Fusion

% 1st step: apply the translation to the second point cloud

load('vector1to2.mat');

t = [   1           0           0           0 
        0           1           0           0
        0           0           1           0
        vector(1)   vector(2)   vector(3)   1];
transform = affine3d(t);
clear t
% bunny = pctransform(bunny,transform);

% 2nd step: create the point clouds from the 3D points

% load('X_proj_keyboard_1.mat');
% load('X_proj_keyboard_2.mat');
% clear -regexp rect
% pointsL = X_proj_keyboard_1;
% pointsR = X_proj_keyboard_2;
% pointsL = reshape(pointsL, [size(pointsL, 1) * size(pointsL, 2), size(pointsL, 3)])';
% pointsR = reshape(pointsR, [size(pointsR, 1) * size(pointsR, 2), size(pointsR, 3)])';
% pcL = pointCloud(pointsL');
% pcR = pointCloud(pointsR');

pcL = pcread('keyboard1c.ply');
pcR = pcread('keyboard2c.ply');

pcR = pctransform(pcR, transform);

% 3rd step: apply the fusion algorithm (ICP + merging) on the point clouds
[~, pcFused] = fuseFrames(pcL, pcR, 0.02, 'pointToPlane', 0.001);

showpc(pcFused, 0.1);






