function [ R, T ] = find_RT( pointsL, pointsR )
%FINDRT SVD estimation of the rigid transform between two sets of points
%   Found on http://nghiaho.com/?page_id=671
%   Original algorithm (ICP) by Besl and McKay, 1992.

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
    
T = R*(-centroidL') + centroidR';

end
