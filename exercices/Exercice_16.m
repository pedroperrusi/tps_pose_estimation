%% Images ? projection perspective mmultiples 
% Exercice 16
clear all; close all;

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
marker_base = stereo_triangulation(T12, m1(:,4), m2(:,4));

disp('The marker base position in camera 1 frame is')
fprintf('\t%.1f\n', marker_base)

%% Extra: Compute marker pose (with orientation)
% use traingulation for at least other three points
marker = [zeros(3, 3) marker_base];
marker(:,1) = stereo_triangulation(T12, m1(:,1), m2(:,1));
marker(:,2) = stereo_triangulation(T12, m1(:,1), m2(:,2));
marker(:,3) = stereo_triangulation(T12, m1(:,2), m2(:,3));
[T, R, t, error] = horn(marker, Pobj);
disp('Pose estimation results:')
disp(T)
disp('Error:')
disp(error)