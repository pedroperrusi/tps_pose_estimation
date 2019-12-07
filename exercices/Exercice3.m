%% Exercice 3
clear all; close all;
%% Input data
% Object coordinates
B = zeros(3, 5);
B(:, 1) = [0; 0; 0];
B(:, 2) = [50; 0; 0];
B(:, 3) = [0; 50; 0];
B(:, 4) = [50; 50; 0];
B(:, 5) = [20; 20; 20];
disp('Object frame coordinates:')
disp(B)
% Image coordinates (px, px, mm)
p = zeros(3, 5);
p(:, 1) = [216; 196; 100];
p(:, 2) = [316; 196; 100];
p(:, 3) = [216; 266.5; 135.6];
p(:, 4) = [316; 266.5; 135.6];
p(:, 5) = [256; 196; 128.4];
disp('Image frame coordinates:')
disp(B)
% Intrinsics matrix (3rd and 4th collumns suposeds)
K = [2 0 0 0;
    0 2 0 0;
    0 0 1 0 % not needed, since p(3,:) is in mm
    0 0 0 1];
iK = inv(K);

%% Solution algebrique (Horn 87, pag 108)
% Convert image frame points to millimeter
P = h_unpack(iK*h_pack(p)); % (mm,mm,mm)

[T, R, t, error] = horn(P, B);
disp('Estimated transformation:')
disp(T)
disp('Reprojection error (mm; mm; mm):');
disp(error);
