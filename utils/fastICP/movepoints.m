function Po=movepoints(M,P)
% This function MOVEPOINTS will transform a N x 3 array of 3D points
% with a 4x4  affine transformation matrix.
%
% PO=MOVEPOINTS(M,P)
%
% inputs,
%    P : M x 3 array with XYZ points
%    M : Affine transformation matrix 4 x 4
%
% outputs,
%    PO : the transformed points
%
% example,
%   % Make some random 3D points
%   P=rand(10,3);
%   % Make a random transformation matrix
%   M = rand(4,4);
%   % Transform the points
%   Po=movepoints(M,P);

Po=P;
Po(:,1)=P(:,1)*M(1,1)+P(:,2)*M(1,2)+P(:,3)*M(1,3)+M(1,4);
Po(:,2)=P(:,1)*M(2,1)+P(:,2)*M(2,2)+P(:,3)*M(2,3)+M(2,4);
Po(:,3)=P(:,1)*M(3,1)+P(:,2)*M(3,2)+P(:,3)*M(3,3)+M(3,4);

if (size(P,2)>5)
    Po(:,4)=P(:,4)*M(1,1)+P(:,5)*M(1,2)+P(:,6)*M(1,3);
    Po(:,5)=P(:,4)*M(2,1)+P(:,5)*M(2,2)+P(:,6)*M(2,3);
    Po(:,6)=P(:,4)*M(3,1)+P(:,5)*M(3,2)+P(:,6)*M(3,3);
end
        