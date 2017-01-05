function [ pointsOut ] = find_points( pointsIn, matches )
%FIND_POINTS Returns the 3D positions of the matching points
%   Simple indexing work.

s = size(matches);

pointsOut = zeros(s(2), 3);

% matlab indexing: the vertical coordinate is the second in the matches
% variable!
for i = 1:s(2)
    pointsOut(i, :) = pointsIn(matches(2, i), matches(1, i), :);
end

end
