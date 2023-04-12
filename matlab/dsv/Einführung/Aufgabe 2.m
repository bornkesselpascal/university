A = randi(100, 4);

A(2,3)
A(3:4,1:3)
A(4, end) % End: letzter Eintrag Zeile/Spalte

B = A - eye(4); % Einheitsmatrix E = [1 1 1 1; 1 1 1 1 ...]
                % zero(1,3): Nullmatrix 1x3

max(A) % Vektor mit Maximum der jew. Spalten
max(max(A))

% Für Hilfe F1
