%% 0. Preamble section

% This section will setup Matlab to work with the folder architecture used.

addpath(genpath('pose_estimation'));
addpath(genpath('measurement'));

addpath(genpath('utils'));
addpath(genpath('data'));

figN = 1;

%% 1. Input section

% This section will mainly consist of setting up arguments (size,
% precision, file formats...) for the following architecture.

% The section will also allow for quick modification of the input files /
% arguments, particularly the choice of the point-cloud file(s) to load as
% well as possible additionnal constraints.

%% 2. Measurement section

% This section will call the methods of the measurement folder, in order to
% retrieve the measurements (mostly vertex and normal information) of the
% point cloud file(s) present in the input section.

% [ B_normal_maps, B_vertex_maps ] = measurement(A_ptCloud, 0);

%% 3. Pose estimation section

% This section will use the pose_estimation folder's methods to estimate
% the pose of the camera given the point-clouds / reconstructed
% point-clouds. The methods will use (maybe different) ICP algorithm(s) to
% perform this task.

% Batch 1 has 25
% Batch 2 has 50
% Batch 3 has 10
% Batch 4 has 50

batchN = 8;
batchO = 1;
batchS = 25;

% FUSION!
batch = batch2cell(batchN, batchO, batchS);

[transforms, fused] = fuseFrames(batch, 0.01, 0.001);

clear batch

% timings: 3 frames ~= 2.5 seconds
% timings: 2 frames ~= 1.3 seconds

% SAVING VALUES
% Saving the fused depth-map
% pcwrite(fused, 'fused.ply');

% Saving the transforms data from data-to-frame
% save('transforms', 'transforms');

% pcshow(fused, 'verticalAxis', 'Y');

downsampledFusion = pcdownsample(fused, 'random', 1);

figure(figN);
figN = figN + 1;
pcshow(downsampledFusion, 'verticalAxis', 'Y'); xlabel('x'); ylabel('y'), zlabel('z');

% b1 = pcread('bun000.ply');
% b2 = pcread('bun045.ply');
% b3 = pcread('bun090.ply');
% 
% q1 = b1.Location;
% s = size(q1);
% q11 = double(reshape(q1, s(2), s(1)));
% p1 = b2.Location;
% s = size(p1);
% p11 = double(reshape(p1, s(2), s(1)));
% 
% [TR1, TT1, aligned1] = icp(q11, p11);
% 
% transform1 = transformFromRotAndTrans(TR1, TT1);
%  
% aligned = pctransform(b2, transform1);
% s = size(aligned1);
% aligned2 = reshape(aligned1, s(2), s(1));
% 
% aligned2 = pointCloud(aligned2);
% 
% merged1 = pcmerge(b1, aligned, 0.0007);

% [TR2, TT2] = icp(merged1, b3);
% 
% merged2 = pcmerge(merged1, aligned2, 0.0007);
% 
% pcshow(merged1);

% FAST ICP TEST
% b1.Normal = pcnormals(b1);
% b2.Normal = pcnormals(b2);
% b3.Normal = pcnormals(b3);
% 
% pose2 = icp_mod_point_plane_pyr(b2.Location, b2.Normal, b3.Location, b3.Normal, 0.05, 100, 3, 1, 8, 0, 0);

%% 4. Reconstruction section

% Aggregation of the surface measurements (with the help of the camera pose
% estimation results) into a reconstructed point-cloud.

% Note: the beginning of the project might use a TSDF instead of a
% point-cloud data representation, to make things easier.

%% 5. Surface prediction section

% This section will use the results of the reconstruction (and the camera
% pose estimation data) to transform the point-cloud data into a continuous
% depth-map with a 3D shape, by ray-casting the TSDF or the point-cloud
% representation.

% Note: even though speed is not vital for the completion of the project,
% the marching step speed-up proposed by Microsoft's paper might be useful
% and more pleasant.

%% 6. Output section

% This section will output the resulting modified point clouds as a merged
% (fused) depth-map point cloud. Parameters for file saving will be
% contained here.
