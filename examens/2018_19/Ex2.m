%% Exercice 2
% Objet connu
% Orientation cherch?

%% Description
% Object geometry
B = [0 40 0;
     0  0 30;
     0  0  0];
% Transform object to needle frame
T_marq_aig = [1 0 0 20;
           0 1 0 20;
           0 0 1 200;
           0 0 0 1];

% Acquisition volumique (imageur 3D)
alpha = [1/0.7;
         1/0.7;
         (-80+40)/20];
     
% Origin z is assumed to be 0
K = [alpha(1) 0      0      512/2;
     0      alpha(2) 0      512/2;
     0        0     alpha(3)  0;
     0 0 0 1];
% mesures du markeur
b = [357 357 317.5;
     343 399 339.5;
     -150 -154 -155.5];
 
%% Conversion metrique
m = h_unpack(inv(K) * h_pack(b));

%% Localization 3D (coupe->marker)
[T_coupe_marker, ~, ~, err] = horn(m, B);
% pose aguille
T_coupe_aig = T_coupe_marker * T_marq_aig;

%% Position desir?e de l'aguille
cible_coupe_px = [271.5;
                400;
                0];
% conversion metrique
cieble_coupe = inv(K) * h_pack(cible_coupe_px);
% represent cieble in aguille frame
cieble_aig = h_unpack(T_coupe_aig * cieble_coupe);
% desired orientation of z points to cieble
desired_z = cieble_aig/norm(cieble_aig);