%% PATH GENERATION AND CLEANING

clear;
clc;

addpath(genpath('alignment'));
addpath(genpath('point_cloud_manip'));

addpath(genpath('utils'));
addpath(genpath('data'));

%% PRE-ALIGNMENT

% load data
% 1->2, 2->3 are recommended translation
% 1->4 is recommended rotation
% 1->5, 4->5 are heavy rotations
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

% finds the matches between the two images manually with 3 points
% [matchesL, matchesR] = manual_match(imL, imR);

% finds the matches between the two images using SIFT (works better with
% high overlapping content)
[matchesL, matchesR] = sift_mosaic2(imL, imR);
matchesL = round(matchesL);
matchesR = round(matchesR);

% finds the 3D points for the matches
posL = find_points(pointsL, matchesL);
posR = find_points(pointsR, matchesR);

% finds the R and T transform that maps POV R to POV L
[R, T] = find_RT(posR, posL);
transform = make_transform(R, T);

%% FUSION

% load data (NEEDS TO MATCH PREVIOUS PART!)
pcL = pcread('k1f.ply');
pcR = pcread('k2f.ply');
pcRt = pctransform(pcR, transform);

% apply the fusion algorithm on the pre-aligned point clouds
% [~, pcFused] = fuseFrames(pcL, pcRt, 0.08, 'pointToPlane', 0.001);

% No-ICP fusion with trivial fusion (doubles size!)
% pcFused = fuse_pc(pcL, pcRt);

% No-ICP fusion with pcmerge
pcFused = pcmerge(pcL, pcRt, 0.001);

figure;
show_pc(pcFused, 0.2); title('Fusion result');

figure;
subplot(1,3,1); show_pc(pcL, 0.1); title('L');
subplot(1,3,2); show_pc(pcRt, 0.1); title('R pre-aligned');
subplot(1,3,3); show_pc(pcR, 0.1); title('R');


