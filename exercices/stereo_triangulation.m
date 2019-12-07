function [ p_obj1, p_obj2 ] = stereo_triangulation( T12, pt1, pt2 )
%STEREO_TRIANGULATION Summary of this function goes here
%   Detailed explanation goes here
n = size(pt1, 2);
R12 = T12(1:3, 1:3);
t12 = T12(1:3, 4);
% express the direction vector reliying the center of the cameras and the
% points in camera 1 frame
origin1 = zeros(3, 1);
dir1 = pt1;
origin2 = t12;
dir2 = R12*pt2;

% Solve the linear system for triangulation Ax = B
A = [dir1 -dir2];
B = origin2-origin1;
x = A\B; % inv(A)*B
p_obj1 = origin1 + x(1)*dir1;
p_obj2 = T12*[p_obj1; 1];
end

