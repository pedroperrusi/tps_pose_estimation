%% Images ? projection perspective mmultiples 
% Exercice 16
clear all; close all;
h_pack = @(points) [points; ones(1, size(points, 2))]; % add homogeneous row
h_unpack = @(h_points, dim) h_points(1:dim, :); % remove homogeneous row
h_normalize = @(mat, dim) mat(1:dim,:)./repmat(mat(dim+1,:), dim, 1);

%% Problem description
% Localization system based in two cameras
% Calibration data:
K1 = [400 0 1000;
      0  400 500;
      0 0 1];
K2 = [410 0 950;
      0 410 550;
      0 0 1];
T12 = [0.9239 0 -0.3827 1000; % extrinsics T1->2
       0      1  0       0;
       0.3827 0 0.9239   0;
       0 0 0 1];
R12 = T12(1:3, 1:3);
t12 = T12(1:3, 4);
% Marker geometry (2dof)
Pobj = [50 50 0  0;
        0  50 80 0;
        0  0  0  0];
% Camera 1 readings
p1 = [1034 1020 997.5 1020;
      526  522.5 517.5 540];
% Camera 2 readings
p2 = [801 792.5 778.5 792.5;
      571 559.5 563.5 582];

%% Compute marker position wrt Camera 1
% it is enough to estimate the position of Pobj(4) in the camera 1 frame

% inverse perspective projection to obtain points in meters.
m1 = inv(K1)*h_pack(p1);
m2 = inv(K2)*h_pack(p2);

% we will use the points m1(:,4) and m2(:,4) to estimate Pobj(4) by
% triangulation in camera 1 reference frame

% express the direction vector reliying the center of the cameras and the
% points in camera 1 frame
origin1 = zeros(3, 1);
dir1 = m1(:, 4);
origin2 = t12;
dir2 = R12*m2(:, 4);

% Solve the linear system for triangulation Ax = B
A = [dir1 -dir2];
B = origin2-origin1;
x = A\B;

% estimate point Pobj(4) with the first line equation
Ori_obj1 = origin1 + x(1)*dir1;
disp('The marker position in camera 1 frame is ')
disp(Ori_obj1);