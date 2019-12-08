%% Exercice 22
clear all; close all;
%% Marker geometry
% first exremity
A = [0 40 0 40;
    0 0 30 30;
    0 0 0 0];
% second extremity
B = [0 40 0 40;
    0 0 30 0;
    100 100 100 100];
% Extrinsics sensor to marker
T = [0.4330  0.5537  0.7113  -24.5;
     -0.7500 0.6590  -0.0564 23.3;
     -0.5000 -0.5090 0.7006  -16.1
     0 0 0 1];
% Measurements
p = [239   315 305   340;
     300.5 237 337.5 251.5];
n = size(p, 2);
%% Intrinsics matrix by DICOM parameters
PixelSpacing = [0.5; 0.5];
ImageDimensions = [512; 512];
% Agrandissements sont l'inverse du pixel spacing
alpha = PixelSpacing.^(-1);
uc = ImageDimensions(1)/2;
vc = ImageDimensions(2)/2;
% on suppose image au centre du capteur
uc = 512/2; vc = 512/2;
K = [alpha(1) 0      uc;
     0      alpha(2) vc;
     0        0      1];
disp('Computed intrinsics matrix:')
disp(K)
iK = inv(K);
disp('Computed inverse intrinsics matrix:')
disp(iK)

%% Convert marker coordinates into scanner frame
As = h_unpack(T*h_pack(A));
Bs = h_unpack(T*h_pack(B));

%% Compute each segment intersection wrt the image frame (Z=0)
% the line equations are modeled as
%       lamda(i) * A(:,i) + (1-lamda(i))*B(:,i) = [px; py; 0]
Pim = zeros(2, n); % points in image frame (mm)
lambda = zeros(n, 1);
for ii = 1:n
    % compute lambda for Z = 0 (image plane)
    lambda(ii) = -B(3, ii)/(A(3, ii) - B(3, ii));
    Pim(:, ii) = lambda(ii)*A(1:2, ii) ...
               + (1 - lambda(ii))*B(1:2, ii);
end
% Convert points coordinates from millimiters into pixels
pim = h_unpack(K*h_pack(Pim));
disp('Marker points in image frame (px/px)')
disp(pim)