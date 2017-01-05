%% PATH GENERATION AND UTILS

clear;
clc;

addpath(genpath('alignment'));
addpath(genpath('point_cloud_manip'));

addpath(genpath('utils'));
addpath(genpath('data'));

%% BATCH CREATION

batchNumber1 = 14;
batchNumber2 = 15;
batchNumber3 = 16;
batchNumber4 = 17;
batchNumber5 = 18;
startIndex = 1;
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

%% STATIC FUSION (takes a bit of time)

% this step fuses the batch of kinect static views into one smoother view
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

%% FUSION OF 2 POV

[transform, fused] = fuseFrames(fused1, fused2, 0.03, 'pointToPlane', 0.001);

%% RESULTS OF STATIC FUSION

figure;
show_pc(fused1, 0.1);

figure;
show_pc(fused2, 0.1);

%% RESULTS OF 2 POV FUSION

figure();
show_pc(fused, 0.5);

%% SAVING VALUES

% Saving the fused depth-maps
pcwrite(fused1, 'fused1.ply');
pcwrite(fused2, 'fused2.ply');
pcwrite(fused3, 'fused3.ply');
pcwrite(fused4, 'fused4.ply');
pcwrite(fused5, 'fused5.ply');
% pcwrite(fused, 'fused.ply'); % too big for git

% Saving the transforms
% save('transformsL', 'transformsL');
% save('transformsR', 'transformsR');
% save('transform', 'transform');


















