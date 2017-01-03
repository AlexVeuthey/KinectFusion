function [ normal_maps, vertex_maps ] = compute_normals( ptCloud )
%MEASUREMENT Compute the normal map and vertex map of a point cloud
%   Can change the spacing between displayed points by passing a
%   spacing argument.

normal_map1 = pcnormals(ptCloud);
vertex_map1 = ptCloud.Location(:,:,:);

ptCloud2 = pcdownsample(ptCloud, 'random', 1/2);
normal_map2 = pcnormals(ptCloud2);
vertex_map2 = ptCloud2.Location(:,:,:);

ptCloud3 = pcdownsample(ptCloud2, 'random', 1/2);
normal_map3 = pcnormals(ptCloud3);
vertex_map3 = ptCloud3.Location(:,:,:);

fieldN = 'f';
valuesN = {normal_map1, normal_map2, normal_map3};
normal_maps = struct(fieldN, valuesN);

fieldV = 'f';
valuesV = {vertex_map1, vertex_map2, vertex_map3};
vertex_maps = struct(fieldV, valuesV);

end
