%% Exercice 10
clear all; close all;

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
Pim = h_normalize(K * T * h_pack(Pobj));
disp('Image des points de lobjet');
disp(Pim);

%% Distance between points
D12 = norm(Pim(:, 1) - Pim(:, 2));
disp('Distance between 1 and 2')
disp(D12)