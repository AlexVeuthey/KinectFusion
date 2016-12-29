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

pcL = pcread('k1c.ply');
pcR = pcread('k2c.ply');

% load the R and T matrices from the calibration
% load('Calib_proj_12.12.2016.mat', 'R_proj');
% load('Calib_proj_12.12.2016.mat', 'T_proj');

% switch to Camera CS (!!! need to do the same for the vector creation)
% pcL = proj2cam(pcL, R_proj, T_proj);
% pcR = proj2cam(pcR, R_proj, T_proj);

pcRt = pctransform(pcR, transform);

% 3rd step: apply the fusion algorithm (ICP + merging) on the point clouds
[~, pcFused] = fuseFrames(pcL, pcRt, 0.3, 'pointToPlane', 0.001);

showpc(pcFused, 0.1);






