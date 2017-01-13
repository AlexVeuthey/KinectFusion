%% PATH GENERATION AND UTILS

clear;
clc;

addpath(genpath('alignment'));
addpath(genpath('point_cloud_manip'));

addpath(genpath('utils'));
addpath(genpath('data'));

%% SINGLE VIEW

pc = pcread('data/kinect_multiple/kinect_batch6/kinect1.ply');

maxDistance = 0.1;

N = 5;

errors = zeros(1,N);

for i = 1:N
    [model, ~, ~, rmse] = pcfitplane(pc, maxDistance);
    errors(i) = rmse;
end

rmse = sum(errors)/N;

figure;
show_pc(pc);
hold on
plot(model);

%% AFTER FUSION

batch = batch2cell(6, 'data/kinect_multiple/kinect_batch', 4);
[~, pcF] = fuseBatch(batch, 0.1, 0.01);

maxDistancef = 0.1;

Nf = 5;

errorsf = zeros(1,Nf);

for i = 1:Nf
    [model, ~, ~, rmsef] = pcfitplane(pcF, maxDistancef);
    errorsf(i) = rmsef;
end

rmsef = mean(errorsf);

figure;
show_pc(pcF);
hold on
plot(model);