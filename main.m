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
% Batch 11 has 25
% Batch 12 has 25
% Batch 13 has 25

batchNumber1 = 14;
batchNumber2 = 15;
batchNumber3 = 16;
batchNumber4 = 17;
batchNumber5 = 18;
batchOffset = 1;
fusionSize = 10;

batch1 = batch2cell(batchNumber1, fusionSize);
batch2 = batch2cell(batchNumber2, fusionSize);
batch3 = batch2cell(batchNumber3, fusionSize);
batch4 = batch2cell(batchNumber4, fusionSize);
batch5 = batch2cell(batchNumber5, fusionSize);

clear batchNumber1
clear batchNumber2
clear batchNumber3
clear batchNumber4
clear batchNumber5
clear fusionSize

%% FUSION ! TAKES A LOT OF TIME

[transforms1, fused1] = fuseBatch(batch1, 0.01, 0.001);
[transforms2, fused2] = fuseBatch(batch2, 0.01, 0.001);
[transforms3, fused3] = fuseBatch(batch3, 0.01, 0.001);
[transforms4, fused4] = fuseBatch(batch4, 0.01, 0.001);
[transforms5, fused5] = fuseBatch(batch5, 0.01, 0.001);

clear batch1
clear batch2
clear batch3
clear batch4
clear batch5

%% ALTERNATIVE: LOAD FROM FILES

fused1 = pcread('fused1.ply');
fused2 = pcread('fused2.ply');
fused3 = pcread('fused3.ply');
fused4 = pcread('fused4.ply');
fused5 = pcread('fused5.ply');

%% FUSION OF CLEAN VIEWS

[transform, fused] = fuseFrames(fused1, fused2, 0.03, 'pointToPlane', 0.001);

% [transform, fused] = fuseFrames(fused2, fused3, 0.015, 'pointToPlane', 0.001);
% [transform, fused] = fuseFrames(fused3, fused4, 0.015, 'pointToPlane', 0.001);
% [transform, fused] = fuseFrames(fused4, fused5, 0.015, 'pointToPlane', 0.001);

%% SHOWING RESULTS OF INDEPENDENT FUSION (STATIC)

downsampledFusion1 = pcdownsample(fused1, 'random', 0.1);

figure(figN);
figN = figN + 1;
pcshow(downsampledFusion1, 'verticalAxis', 'Y'); xlabel('x'); ylabel('y'), zlabel('z');

downsampledFusion2 = pcdownsample(fused2, 'random', 0.1);

figure(figN);
figN = figN + 1;
pcshow(downsampledFusion2, 'verticalAxis', 'Y'); xlabel('x'); ylabel('y'), zlabel('z');

%% SHOWING RESULTS OF 2 POV FUSION

downsampledFusion = pcdownsample(fused, 'random', 0.5);

figure(figN);
figN = figN + 1;
pcshow(downsampledFusion, 'verticalAxis', 'Y'); xlabel('x'); ylabel('y'); zlabel('z');

%% SAVING VALUES

% Saving the fused depth-map
pcwrite(fused1, 'fused1.ply');
pcwrite(fused2, 'fused2.ply');
pcwrite(fused3, 'fused3.ply');
pcwrite(fused4, 'fused4.ply');
pcwrite(fused5, 'fused5.ply');
% pcwrite(fused, 'fused.ply'); % too big for git

% Saving the transforms data from data-to-frame
% save('transformsL', 'transformsL');
% save('transformsR', 'transformsR');
% save('transform', 'transform');


















