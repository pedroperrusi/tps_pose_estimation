%% Exercice 5
clear all; close all;
%% Input data
% Points du support dans son repere
Ps_s = [100 300 200 0;
        0    0  200 0;
        0    0   0  200];
% Points du pointeur dans son repere
Pp_p = [0 20 50;
        0  0  0;
        0  0  0];
% pointer tip
Pt_p = [100;
        0;
        0];
% Mesures du capteur
% transformations entre son repere et le pointeur lorqu'il pointe les
% points du support;
m = 3;
Tloc_p = {};
Tloc_p{1} = [0.7071 0.5000 -0.5000 486.5;
             -0.3536 0.8624 0.3624 357.7;
             0.6124 -0.0795 0.7866 1517.7;
             zeros(1, 3)            1];
Tloc_p{2} = [0.1419 0.5702 -0.8091 657.4;
             0.0164 0.8160 0.5779  365.3;
             0.9898 -0.0952 0.1064 1637.8;
             zeros(1, 3)            1];
Tloc_p{3} = [0.6984 0.4493 -0.557  461.4;
             -0.4847 0.8696 0.0938 574.8;
             0.06266 0.2045 0.8252 1614.1;
             zeros(1, 3)            1];
%% Step 1: Points du support dans le repere du capteur
Ps_loc = [];
for i = 1:m
    Ps_loc(:,i) = h_unpack(Tloc_p{i} * h_pack(Pt_p));
end
%% Step 2: 3D Localization based on the 3 points
Pobj = Ps_s(:, 1:3); % only first three points are used
[T, R, t, error] = horn(Ps_loc, Pobj);