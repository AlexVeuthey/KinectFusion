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

% load('vector1to2.mat');
% t = [   1           0           0           0 
%         0           1           0           0
%         0           0           1           0
%         vector(1)   vector(2)   vector(3)   1];
% transform = affine3d(t);
% clear t

imL = imread('keyboard1.jpg');
imR = imread('keyboard2.jpg');

load('X_proj_keyboard_1.mat');
load('X_proj_keyboard_2.mat');
rectL = rect_keyboard_1;
rectR = rect_keyboard_2;
pointsL = X_proj_keyboard_1;
pointsR = X_proj_keyboard_2;

clear -regexp rect_keyboard X_proj ;

imL = imcrop(imL, rectL);
imR = imcrop(imR, rectR);

% recovers the matches between the two cropped images (= the same indexing
% as the depth data)
% [matchesL, matchesR] = sift_mosaic(imL, imR);

matchesL = round(matchesL);
matchesR = round(matchesR);

posL = find_points(pointsL, matchesL);
posR = find_points(pointsR, matchesR);

locL = [mean(posL(:,1)), mean(posL(:,2)), mean(posL(:,3))];
locR = [mean(posR(:,1)), mean(posR(:,2)), mean(posR(:,3))];

vector = [locL(1) - locR(1), locL(2) - locR(2), locL(3) - locR(3)];

t = [   1           0           0           0 
        0           1           0           0
        0           0           1           0
        vector(1)   vector(2)   vector(3)   1];
transform = affine3d(t);
clear t ;

%% 2nd step: create the point clouds from the 3D points

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
[~, pcFused] = fuseFrames(pcL, pcRt, 0.1, 'pointToPlane', 0.001);

showpc(pcFused, 0.1);


