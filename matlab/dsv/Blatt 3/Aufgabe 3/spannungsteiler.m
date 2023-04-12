% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 3, Aufgabe 3

function u_k = spannungsteiler(u_r,r_k, r_ges)
% u_r:   Referenzspannung
% r_k:   Widerstand
% r_ges: Gesamtwiderstand
% u_k:   Abfallende Spannung über Widerstand

u_k = u_r .* (r_k ./ r_ges);

end

