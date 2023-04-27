% 
% V3_Parameter.m
% Praktikum_MDS
%
% Created by Pascal Julian Bornkessel on 23.05.22.
%


%
% 1) Elektrischer Kreis
%

R_A = 2.569;                % [Ohm]
L_A = 4.873 * (10^(-3));    % [H]

num = [1];
den = [L_A R_A];


%
% 2) Mechanische Komponenten
%

k_M = 0.107646;             % [Nm/A]
i_G = 62;                   % [?]

m_G = 2;                    % [kg]
g   = 9.81;                 % [m/s^2]
r_S = 0.1;                  % [m]

J_M = 5.5 * (10^(-5));      % [kg m^2] 
J_S = 0.003;                % [kg m^2] 
J   = J_M * (i_G)^2 + J_S + m_G * (r_S)^2;  % [kg m^2] 


%
% 3) Reibungskennlinie
%

KL_REIB = [-2.32446  -1.72725  -1.14312  -0.55627  -0.001   0  0.001    0.296462  0.893574  1.47885  2.07879;
           -3.18335  -3.06322  -2.90304  -2.64943  -2.64943 0  2.94343  2.94343   3.07691   3.31718  3.55077];

