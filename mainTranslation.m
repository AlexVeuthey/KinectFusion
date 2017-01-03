%% PATH GENERATION AND CLEANING

clear;
clc;

addpath(genpath('pose_estimation'));
addpath(genpath('measurement'));

addpath(genpath('utils'));
addpath(genpath('data'));

%% PRE-ALIGNMENT

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

% finds the matches between the two images
[matchesL, matchesR] = sift_mosaic2(imL, imR);
matchesL = round(matchesL);
matchesR = round(matchesR);

% finds the 3D points for the matches
posL = find_points(pointsL, matchesL);
posR = find_points(pointsR, matchesR);

% finds the R and T transform that maps POV R to POV L
[R, T] = findRT(posR, posL);
transform = make_transform(R, T);

% ONLY TRANSLATION FROM SIFT CORRESPONDENCES
% meanL = [mean(posL(:,1)), mean(posL(:,2)), mean(posL(:,3))];
% meanR = [mean(posR(:,1)), mean(posR(:,2)), mean(posR(:,3))];
% 
% vector = [meanL(1) - meanR(1), meanL(2) - meanR(2), meanL(3) - meanR(3)];
% 
% t = [   1           0           0           0 
%         0           1           0           0
%         0           0           1           0
%         vector(1)   vector(2)   vector(3)   1];
% transform = affine3d(t);
% clear t ;

%% FUSION

pcL = pcread('k1f.ply');
pcR = pcread('k2f.ply');
pcRt = pctransform(pcR, transform);

% apply the fusion algorithm on the pre-aligned point clouds
[~, pcFused] = fuseFrames(pcL, pcRt, 0.1, 'pointToPlane', 0.001);

showpc(pcFused, 0.1);


