function [ transform ] = transformFromRotAndTrans( TR, TT )
%TRANSFORMFROMROTANDTRANS Summary of this function goes here
%   Detailed explanation goes here

transformMatrix = zeros(4, 4);

transformMatrix(1:3, 1:3) = TR;
transformMatrix(4, 1:3) = TT.';
transformMatrix(4, 4) = 1;

transform = affine3d(inv(transformMatrix));

end
