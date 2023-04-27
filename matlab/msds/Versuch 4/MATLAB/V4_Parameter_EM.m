% 
% V4_Parameter_EM.m
% Praktikum_MDS
%
% Created by Pascal Julian Bornkessel on 13.06.22.
%


%
% 1) Elektrischer Kreis
%

R_A  = 0.36;                 % [Ohm]
L_A  = 0.11 * (10^(-3));     % [H]

k_M  = -0.038462;            % [Nm/A]

r_ZR = 25 * (10^(-3));       % [m]

%
% 2) Kennlinie R_VH
%

KL_R_VH = [10      20      30      40;
           0.5645  0.3225  0.2815  0.242];