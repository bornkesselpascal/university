% PARALLELER RLC SCHWINGKREIT
% GEMESSENE PARAMETER

R_v = 474.6;  % [Ohm] 
R_d = 979.2; % [Ohm]
R_L = 0.82;  % [Ohm]

L = 2.29433 * (10^(-3));  % [Henry]

C = 1 * (10^(-6));  % [Farad]


num = [(R_d * L) (R_d * R_L)];
den = [(C*L*R_d*R_v) (R_d*L + R_v*L + R_v*R_d*R_L*C) (R_d*R_L + R_v*R_L + R_v*R_d)];

G = tf(num,den);