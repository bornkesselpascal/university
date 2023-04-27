% Mathematisches Pendel
% Stahlkugel

m   = 1.396;    % [kg]
l_s = 0.576;    % [m]
s   = 0.01;     % [m]
r_k = 0.034875; % [m]

d       = 0.0035;    % [-]
phi_0   = Amplitude(1); % [deg]
g       = 9.81; % [m/s^2]


phi_0_rad   = phi_0 * (pi/180); % [rad]
l           = l_s - s + r_k;    % [m]
J           = m * (l.^2);       % [kg m^2]