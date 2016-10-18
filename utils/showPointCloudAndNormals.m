function [  ] = showPointCloudAndNormals( ptCloud, vertex_map, normal_map, spacing )
%SHOWPOINTCLOUDANDNORMALS Shows a point cloud with some points' normal.
%   Detailed explanation goes here

figure
pcshow(ptCloud); xlabel('X'); ylabel('Y'); zlabel('Z');
title('Estimated Normals of Point Cloud');
hold on
x = vertex_map(1:spacing:end,1);
y = vertex_map(1:spacing:end,2);
z = vertex_map(1:spacing:end,3);
u = normal_map(1:spacing:end,1);
v = normal_map(1:spacing:end,2);
w = normal_map(1:spacing:end,3);

% MIGHT NEED TO CHANGE THAT

% sensorCenter = [-5, 0, 0.1];
% for k = 1 : numel(x)
%     p1 = sensorCenter - [x(k),y(k),z(k)];
%     p2 = [u(k),v(k),w(k)];
%     % Flip the normal vector if it is not pointing towards the sensor.
%     angle = atan2(norm(cross(p1,p2)),p1*p2');
%     if angle > pi/2 || angle < -pi/2
%         u(k) = -u(k);
%         v(k) = -v(k);
%         w(k) = -w(k);
%     end
% end

quiver3(x,y,z,u,v,w);
hold off

end

