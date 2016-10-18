function [ normal_maps, vertex_maps ] = measurement( ptCloud, show_normals, spacing )
%MEASUREMENT Compute the normal map and vertex map of a point cloud
%   Can display the normal map on the vertex map when passing show_normals
%   = 1.
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

if show_normals == 1
    if nargin < 3
        spacing = 10;
    end
    showPointCloudAndNormals(ptCloud, vertex_map1, normal_map1, spacing);
    %showPointCloud(ptCloud);
%     figure
%     pcshow(ptCloud)
%     title('Estimated Normals of Point Cloud');
%     hold on
%     if nargin < 3
%         spacing = 10;
%     end
%     x = vertex_map1(1:spacing:end,1);
%     y = vertex_map1(1:spacing:end,2);
%     z = vertex_map1(1:spacing:end,3);
%     u = normal_map1(1:spacing:end,1);
%     v = normal_map1(1:spacing:end,2);
%     w = normal_map1(1:spacing:end,3);
%     
%     sensorCenter = [-5, 0, 0.1];
%     for k = 1 : numel(x)
%         p1 = sensorCenter - [x(k),y(k),z(k)];
%         p2 = [u(k),v(k),w(k)];
%         Flip the normal vector if it is not pointing towards the sensor.
%         angle = atan2(norm(cross(p1,p2)),p1*p2');
%         if angle > pi/2 || angle < -pi/2
%             u(k) = -u(k);
%             v(k) = -v(k);
%             w(k) = -w(k);
%         end
%     end
%     
%     quiver3(x,y,z,u,v,w);
%     hold off
end

end
