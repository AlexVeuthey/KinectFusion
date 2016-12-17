function [ ptCloudOut ] = croppc( ptCloudIn, var, m )
%CROPPOINTCLOUD Summary of this function goes here
%   Detailed explanation goes here

locA = ptCloudIn.Location;

if nargin < 2
    var = [50,50,50];
end
if nargin < 3
    m = [mean(locA(:,1)),mean(locA(:,2)),mean(locA(:,3))];
end

locB = zeros(size(locA));

validPoints = 1;

for i = 1:size(locA(:,3))
    x = locA(i,1);
    y = locA(i,2);
    z = locA(i,3);
    if (x > m(1) - var(1)) && (x < m(1) + var(1))
        if (y > m(2) - var(2)) && (y < m(2) + var(2))
            if (z > m(3) - var(3)) && (z < m(3) + var(3))
                locB(validPoints,:) = locA(i,:);
                validPoints = validPoints + 1;
            end
        end
    end
end

locB = locB(1:validPoints-1, :);

ptCloudOut = pointCloud(locB);

end
