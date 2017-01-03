function [ R, T ] = findRT( pointsL, pointsR )
%FINDRT Summary of this function goes here
%   Detailed explanation goes here

s = size(pointsL(:,1));

centroidL = [mean(pointsL(:,1)), mean(pointsL(:,2)), mean(pointsL(:,3))];
centroidR = [mean(pointsR(:,1)), mean(pointsR(:,2)), mean(pointsR(:,3))];

centeredL = pointsL - centroidL;
centeredR = pointsR - centroidR;

H = [   0   0   0
        0   0   0
        0   0   0   ];
    
for i = 1:s
    H = H + centeredL(i,:)'*centeredR(i,:);
end

[U,~,V] = svd(H);

if det(V) < 0
    V(:,3) = -V(:,3);
end

R = V*U';
    
T = -R*centroidL' + centroidR';

end
