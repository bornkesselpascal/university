% Physikalisches Pendel
% Styroporkugel

s   = 0.01;     % [m]
r_k = 0.0344;   % [m]

d       = 0.0016;       % [-]
phi_0   = Amplitude(1); % [deg]
g       = 9.81; % [m/s^2]

m_A = 0.4;             % [kg]
m_S = 0.0777;          % [kg]
m_K = 0.0047;          % [kg]
m   = m_A + m_S + m_K; % [kg]

l_S  = 0.576;                         % [m]
l_SS = l_S / 2;                       % [m]
l_SK = l_S - s + r_k;                 % [m]
l    = (l_SS * m_S + l_SK * m_K) / m; % [m]

J_A  = 3.4602 * (10^(-5));                                  % [kg m^2]
J_KA = (2/5) * m_K * (r_k.^2) + m_K * ((l_S - s + r_k).^2); % [kg m^2]
J_SA = (1/3) * m_S * (l_S.^2);                              % [kg m^2]
J    = J_A + J_SA + J_KA;                                   % [kg m^2]

phi_0_rad   = phi_0 * (pi/180); % [rad]