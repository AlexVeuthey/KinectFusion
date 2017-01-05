function [ pointsCam ] = proj2camPoints( pointsProj, R, T )
%PROJ2CAMPOINTS Transforms the array of points in camera CS
%   Formulas from email.

size1 = size(pointsProj, 1);
size2 = size(pointsProj, 2);
size3 = size(pointsProj, 3);

pointsProj = reshape(pointsProj, [size1 * size2, size3])';

num_points = size(pointsProj, 2);

pointsCam  = R \ (pointsProj - repmat(T, [1, num_points]));

pointsCam = reshape(pointsCam, [size1, size2, size3]);

end
