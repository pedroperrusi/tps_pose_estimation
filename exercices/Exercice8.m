%% Exercice 8
clear all; close all;

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
m = inv(K)*h_pack(Pim);

%% Compute quadratic equation values for each pair of points
qeq_distances(m, Pobj);
