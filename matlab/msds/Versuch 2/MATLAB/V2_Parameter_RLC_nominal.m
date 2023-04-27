% PARALLELER RLC SCHWINGKREIT
% NOMINALE PARAMETER

R_v = 470;  % [Ohm] 
R_d = 1000; % [Ohm]
R_L = 0.8;  % [Ohm]

L = 2 * (10^(-3));  % [Henry]

C = 1 * (10^(-6));  % [Farad]


num = [(R_d * L) (R_d * R_L)];
den = [(C*L*R_d*R_v) (R_d*L + R_v*L + R_v*R_d*R_L*C) (R_d*R_L + R_v*R_L + R_v*R_d)];

G = tf(num,den);