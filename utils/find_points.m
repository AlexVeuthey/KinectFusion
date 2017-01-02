function [ pointsOut ] = find_points( pointsIn, matches )
%FIND_POINTS Summary of this function goes here
%   Detailed explanation goes here

s = size(matches);

pointsOut = zeros(s(2), 3);

% the first coord. of the matches variable is the first one!
for i = 1:s(2)
    pointsOut(i, :) = pointsIn(matches(2, i), matches(1, i), :);
end

end
