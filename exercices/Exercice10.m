%% Exercice 10
clear all; close all;
% handle functions
h_pack = @(points) [points; ones(1, size(points, 2))]; % add homogeneous row
h_unpack = @(h_points) h_points(1:3, :); % remove homogeneous row
h_normalize = @(mat, dim) mat(1:dim,:)./repmat(mat(dim+1,:), dim, 1);
% Matrice de projection intrinseque
K = [1200 0 960;
     0  800 540;
     0   0   1];
 T = [0.707 -0.707 0 -25;
      0.707 0.707  0  50;
      0      0     -1 250];
  
Pobj = [0 0 0;
        60 60 0]';
  
%% Les positions du centre le l'image sont deja dans K
disp('[uc; vc] = ')
disp(K(1:2, 3));

%% Calculez l'image de l'object
Pim = h_normalize(h_unpack(K * T * h_pack(Pobj)), 2);
disp('Image des points de lobjet');
disp(Pim);

%% Distance between points
D12 = norm(Pim(:, 1) - Pim(:, 2));
disp('Distance between 1 and 2')
disp(D12)