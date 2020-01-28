%% Exercice 1
clear all; close all;
%% Problem description
K1 = [2000 0 1000;
      0 1900 520;
      0  0 1];
K2 = [2100 0 950;
      0 1800 550;
      0 0 1];

T12 = [0.8001   0.3827   -0.4619    300;
       -0.3314  0.9239    0.1913    10;
       0.5      0         0.8660    -20;
       0 0 0 1];

% Object geometry
Pobj = [25  0  -25;
        0  30  -30;
        0   0   0];
% Image measurements
p1 = [1280 1243 1336.5;
      897 845.5 904.5];
p2 = [1665 1644.5 1690;
      771.5 710 788];
 
%% Inverse perspective projection (to get mm)
m1 = inv(K1) * h_pack(p1);
m2 = inv(K2) * h_pack(p2);

%% Compute physical points by stereo triangulation
Pobj_1 = zeros(size(Pobj)); % camera 1 frame
for ii = 1:size(Pobj, 2)
    Pobj_1(:, ii) = stereo_triangulation(T12, m1(:,ii), m2(:,ii));
end
% Obtain object pose wrt camera 1
[T1obj, ~, ~, error] = horn(Pobj_1, Pobj);
disp('1.3: Object pose wrt camera 1:');
disp(T1obj);
disp('Reprojection error:');
disp(error);

%% 2nd study case: Object geometry unknown
% Image measurements
p1 = [1285.5 1272  1221.5 1229;
      882    916.5 858    833.5];
p2 = [1666 1663.5 1636.5 1637;
      756  792.5  721    695];
n = size(p1, 2);
% Inverse perspective projection
m1 = inv(K1) * h_pack(p1);
m2 = inv(K2) * h_pack(p2);
% Compute physical points for both camera frames
Pobj_1 = zeros(3, n); % camera 1 frame
Pobj_2 = zeros(3, n); % camera 2 frame
for ii = 1:n
    [Pobj_1(:, ii), Pobj_2(:, ii)] = stereo_triangulation(T12, m1(:,ii), m2(:,ii));
end
% Compute object transform wrt each camera frame
[T1obj, ~, ~, error] = horn(Pobj_1, Pobj_2);
[T2obj, ~, ~, error] = horn(Pobj_2, Pobj_1);
% Wrong!
% T12*T1obj = eye(4);