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
% 4->5 is recommended rotation
% 1->4, 1->5 are heavy rotations
indL = 1;
indR = 4;
imL = imread(strcat('keyboard',num2str(indL),'.jpg'));
imR = imread(strcat('keyboard',num2str(indR),'.jpg'));
dataL = load(strcat('keyboard_',num2str(indL),'.mat'));
dataL = dataL.s;
dataR = load(strcat('keyboard_',num2str(indR),'.mat'));
dataR = dataR.s;
rectL = dataL.rect;
rectR = dataR.rect;
pointsL = dataL.points;
pointsR = dataR.points;
clear dataL dataR ;
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
transformSIFT = make_transform(R, T);

%% FUSION

% load point clouds
pcL = pcread(strcat('k',num2str(indL),'f.ply'));
pcR = pcread(strcat('k',num2str(indR),'f.ply'));
pcRt = pctransform(pcR, transformSIFT);

% apply the fusion algorithm on the pre-aligned point clouds
[transformICP, pcFused] = fuse_viewpoints(pcRt, pcL, 0);

% shows the result
figure;
show_pc(pcFused, 0.3); title('Fusion result');

% shows the pre-alignment done by SIFT
figure;
subplot(1,3,1); show_pc(pcL, 0.1); title('L');
subplot(1,3,2); show_pc(pcRt, 0.1); title('R pre-aligned');
subplot(1,3,3); show_pc(pcR, 0.1); title('R');

% shows the fusion with only SIFT
siftFused = fuse_pc(pcL, pcRt);
figure;
show_pc(siftFused, 0.5); title('SIFT-only fusion result');




