function [ transform ] = make_transform( R, T )
%MAKE_TRANSFORM Creates an Affine3D transform out of R and T matrices
%   Trivial

t = [   R(1,1)  R(1,2)  R(1,3)   0
        R(2,1)  R(2,2)  R(2,3)   0
        R(3,1)  R(3,2)  R(3,3)   0
        T(1)    T(2)    T(3)     1   ];
    
transform = affine3d(t);

end
