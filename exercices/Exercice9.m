%% Exercice 9
clear all; close all;
% handle functions
h_pack = @(points) [points; ones(1, size(points, 2))]; % add homogeneous row
h_normalize = @(mat, dim) mat(1:dim,:)./repmat(mat(dim+1,:), dim, 1);

%% Input data
% Object coordinates
Pobj = [0 50 0  0   50;
        0 0  50 0   50;
        0 0  0  50  50];
 % mesures
 Pim = [324.3 450 433.1 377.5;
        119.5 20.8 247.2 60.2];
    
%% Intrinsics matrix by DICOM parameters
DistanceSourcetoDetector = 800;
ImgDims = [512 512]; % rows and cols
PhysicalDetectorSize = [300 300];
Gx = DistanceSourcetoDetector*ImgDims(1)/PhysicalDetectorSize(1);
Gy = DistanceSourcetoDetector*ImgDims(2)/PhysicalDetectorSize(2);
% on suppose image au centre du capteur
uc = 512/2; vc = 512/2;
K = [Gx 0 uc;
     0 Gy vc;
     0 0 1];
disp('Computed intrinsics matrix:')
disp(K)
iK = inv(K);
disp('Computed inverse intrinsics matrix:')
disp(iK)

%% Compute perspective projection
m = iK*h_pack(Pim);

%% Compute quadratic equation values for each pair of points
qeq_distances(m, Pobj);

%% Some sistances between object points and the camera frame are given
D = [402.5 379.7 409.4 446.2];
% Given one point m(:,i) and its distance to the optique center we can find
% the object position
position = D(1) * m(:,1)/norm(m(:,1));
disp('Object position is')
disp(position)
