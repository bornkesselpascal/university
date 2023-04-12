% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 3, Aufgabe 3

function u_out = komparator(pos, neg, u_cc, u_ee)
% pos:   positiver nicht-invertierter Eingang (Spannung)
% neg:   negativer invertierter Eingang (Spannung)
% u_cc:  positive Versorgungsspannung
% u_ee:  negative Versorgungsspannung
% u_out: Ausgangssingal

if pos > neg
    u_out = u_cc;
else
    u_out = u_ee;
end

end

