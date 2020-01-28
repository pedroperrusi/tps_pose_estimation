%% Exercice 24: Cadre de Brown-Roberts-Wells
clear all; close all;

%% Problem description
% Marker segment coordiantes S = (A, B)
% First extremities
A = [0 0 50;
     0 0 50;
     0 0 0;
     0 0 0;
     0 50 0;
     0 50 0;
     0 50 50]';
% Second extremities
B = [80 0 50;
     80 0 0;
     80 0 0;
     80 50 0;
     80 50 0;
     80 50 50;
     80 50 50]';

% Measures:
p = [254.5 173.5;
     284.5 222.5;
     302   251;
     282.5 270.5;
     247   306;
     229.5 276.5;
     200   228]';
 
%% Intrinsics matrix by DICOM parameters
PixelSpacing = [0.7; 0.7];
ImageDimensions = [512; 512];
% Agrandissements sont l'inverse du pixel spacing
alpha = PixelSpacing.^(-1);
% on suppose image au centre du capteur
uc = ImageDimensions(1)/2;
vc = ImageDimensions(2)/2;
% Assemble K
K = [alpha(1) 0      uc;
     0      alpha(2) vc;
     0        0      1];
disp('Computed intrinsics matrix:')
disp(K)
iK = inv(K);
disp('Computed inverse intrinsics matrix:')
disp(iK)

%% Estimer la pose complete du cadre BRW
% The non diagonal bars dimensions are
L_axis = max(abs(A - B), [], 2);
% Diagonal bars dimensions between each plane
pitagores = @(l1, l2) sqrt(l1*l1 + l2*l2);
L_diag = [pitagores(L_axis(1), L_axis(2)); % xy
          pitagores(L_axis(1), L_axis(3)); % xz
          pitagores(L_axis(2), L_axis(3))];% yz