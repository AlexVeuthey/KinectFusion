%% 0. Preamble section

% This section will setup Matlab to work with the folder architecture used.

addpath(genpath('surface_prediction'));
addpath(genpath('reconstruction'));
addpath(genpath('pose_estimation'));
addpath(genpath('measurement'));

addpath(genpath('utils'));
addpath(genpath('data'));

batchN = 1;

%% 1. Input section

% This section will mainly consist of setting up arguments (size,
% precision, file formats...) for the following architecture.

% The section will also allow for quick modification of the input files /
% arguments, particularly the choice of the point-cloud file(s) to load as
% well as possible additionnal constraints.

A_ptCloud = pcread('bun_zipper.ply');

rot = [
    1   0               0               0 
    0   cos(3*pi/2)     -sin(3*pi/2)    0
    0   sin(3*pi/2)     cos(3*pi/2)     0
    0   0               0               1
    ];

transform = affine3d(rot);
A_ptCloud = pctransform(A_ptCloud,transform);

clear rot transform

%% 2. Measurement section

% This section will call the methods of the measurement folder, in order to
% retrieve the measurements (mostly vertex and normal information) of the
% point cloud file(s) present in the input section.

[ B_normal_maps, B_vertex_maps ] = measurement(A_ptCloud, 1);

%% 3. Pose estimation section

% This section will use the pose_estimation folder's methods to estimate
% the pose of the camera given the point-clouds / reconstructed
% point-clouds. The methods will use (maybe different) ICP algorithm(s) to
% perform this task.

% Note: the ICP algorithms might already have been implemented somewhere
% else that can be used...

pathName = batchAndNumberToPath(batchN,1);

ptCloud = pcread(pathName);

pcshow(ptCloud,'verticalAxis','Y'); xlabel('x'); ylabel('y'); zlabel('z');

clear pathName

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
