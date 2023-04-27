% 
% V4_Parameter_Wagen_Te.m
% Praktikum_MDS
%
% Created by Pascal Julian Bornkessel on 13.06.22.
%



%
% 1) Fahrwiderstände
%

c_W   = 0.81;
rho_L = 1.2;            % [kg/m^3]
A     = 0.01155;        % [m^2]

mu_R  = 0.045;


%
% 2) Drehmassenfaktor
%

m_R = 0.0298;               % [kg]
J_R = 1.016 * (10^(-5));    % [kgm^2]
r_R = 0.025;                % [m]

m_W     = 1.604;            % [kg]
m_Trans = m_W + 4*m_R;      % [kg]

J_EM = 164 * (10^(-7));     % [kgm^2]
J_KR = 1.057 * (10^(-6));   % [kgm^2]
J_W  = 2.333 * (10^(-7));   % [kgm^2]
J_ZR = 6.123 * (10^(-6));   % [kgm^2]
r_ZR = 0.021;               % [m]

m_ErsatzAntrieb = (J_EM + 4*J_KR + J_W + J_ZR) / (r_ZR.^2);    % [kg]
m_ErsatzRad     = (4*J_R) / (r_R.^2);

k = (m_Trans + m_ErsatzAntrieb + m_ErsatzRad) / (m_Trans) ;


%
% 3) Sonstige
%

g         = 9.81;                   % [m/s^2]
gamma_deg = 20;                     % [deg]
gamma_rad = gamma_deg * (pi/180);   % [rad]
k_M       = -0.038462;              % [Nm/A]