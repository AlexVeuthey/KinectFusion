%% PATH GENERATION AND UTILS

% This section will setup Matlab to work with the folder architecture used.

clear;
clc;

addpath(genpath('pose_estimation'));
addpath(genpath('measurement'));

addpath(genpath('utils'));
addpath(genpath('data'));

figN = 1;

%% BATCH CREATION

% Batch 1 has 25
% Batch 2 has 50
% Batch 3 has 10
% Batch 4 has 50
% Batch 5 has 25
% Batch 6 has 25
% Batch 7 has 25
% Batch 8 has 25
% Batch 9 has 25
% Batch 10 has 25

batchNumberL = 9;
batchNumberR = 10;
batchOffset = 1;
fusionSize = 25;

batchL = batch2cell(batchNumberL, fusionSize);
batchR = batch2cell(batchNumberR, fusionSize);

%% FUSION ! TAKES A LOT OF TIME

[transformsL, fusedL] = fuseBatch(batchL, 0.01, 0.001);
[transformsR, fusedR] = fuseBatch(batchR, 0.01, 0.001);

clear batchL
clear batchR

%% ALTERNATIVE: LOAD FROM FILES

fusedL = pcread('fusedL.ply');
fusedR = pcread('fusedR.ply');

%% FUSION OF CLEAN VIEWS

[transform, fused] = fuseFrames(fusedL, fusedR, 0.015, 'pointToPlane', 0.001);

%% SHOWING RESULTS OF INDEPENDENT FUSION (STATIC)

downsampledFusionL = pcdownsample(fusedL, 'random', 0.1);

figure(figN);
figN = figN + 1;
pcshow(downsampledFusionL, 'verticalAxis', 'Y'); xlabel('x'); ylabel('y'), zlabel('z');

downsampledFusionR = pcdownsample(fusedR, 'random', 0.1);

figure(figN);
figN = figN + 1;
pcshow(downsampledFusionR, 'verticalAxis', 'Y'); xlabel('x'); ylabel('y'), zlabel('z');

%% SHOWING RESULTS OF 2 POV FUSION

downsampledFusion = pcdownsample(fused, 'random', 0.5);

figure(figN);
figN = figN + 1;
pcshow(downsampledFusion, 'verticalAxis', 'Y'); xlabel('x'); ylabel('y'); zlabel('z');

%% SAVING VALUES

% Saving the fused depth-map
pcwrite(fusedL, 'fusedL.ply');
pcwrite(fusedR, 'fusedR.ply');
% pcwrite(fused, 'fused.ply'); % too big...

% Saving the transforms data from data-to-frame
save('transformsL', 'transformsL');
save('transformsR', 'transformsR');
save('transform', 'transform');


















