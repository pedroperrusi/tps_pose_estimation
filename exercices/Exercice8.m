%% Exercice 8
clear all; close all;
% handle functions
h_pack = @(points) [points; ones(1, size(points, 2))]; % add homogeneous row
h_unpack = @(h_points) h_points(1:3, :); % remove homogeneous row
h_normalize = @(mat, dim) mat(1:dim,:)./repmat(mat(dim+1,:), dim, 1);

%% Input data
% Object coordinates
Pobj = [0 10 10 0  5;
        0 0  10 10 5;
        0 0  0  0  5];
% intrinsics matrix
K = [800 0 400;
     0 800 400;
     0   0   1];
 % mesures
 Pim = [416 565 518.5 382.5 496.5;
        368 426 571 506.5 447.5];
    
%% Compute perspective projection
m = h_unpack(inv(K)*h_pack(Pim));

%% Compute quadratic equation values for each pair of points
qeq_distances(m, Pobj);
