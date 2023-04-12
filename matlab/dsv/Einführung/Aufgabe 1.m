M_A = [1 2 ; 3 4];
M_B = [2 6 ; 1 4];

C = M_A + M_B;
D = M_A - M_B;
E = M_A + 2;     % 2 mit Einheitsmatrix
F = M_A * M_B;   % Matrix mult
G = M_A .* M_B;  % Elemente mult
H = M_A / M_B;
I = M_A';        % Invertieren
J = M_A > M_B;   % Elementweise verglichen
