function [ normal_map, vertex_map ] = measurement( ptCloud, show_normals, spacing )
%MEASUREMENT Computer the normal map and vertex map of a point cloud
%   Can display the normal map on the vertex map when passing show_normals
%   = 1. 
%   Can change the spacing between displayed points by passing a
%   spacing argument.

normal_map = pcnormals(ptCloud);
vertex_map = ptCloud.Location(:,:,:);

if show_normals == 1
    figure
    pcshow(ptCloud)
    title('Estimated Normals of Point Cloud');
    hold on
    if nargin < 3
        spacing = 10;
    end
    x = vertex_map(1:spacing:end,1);
    y = vertex_map(1:spacing:end,2);
    z = vertex_map(1:spacing:end,3);
    u = normal_map(1:spacing:end,1);
    v = normal_map(1:spacing:end,2);
    w = normal_map(1:spacing:end,3);
    quiver3(x,y,z,u,v,w);
    hold off
end

end
