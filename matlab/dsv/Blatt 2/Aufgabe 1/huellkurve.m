% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 2, Aufgabe II.1

function y = huellkurve(a,d,s,ed,es,x)
% a : Relative Laenge Attack Phase
% d : Relative Laenge Delay Phase, d- a
% s : Relative Laenge Sustain Phase, s- d
% ed : Relative Amplitude des Profils zum Zeitpunkt d
% es : Relative Amplitude des Profils zum Zeitpunkt s
% x : Eingangston
% y : Veraenderter Ausgangston

total_l = length(x);        % Totale Gesamtlaenge
total_a = round(total_l * a);      % Totale Laenge Attack Phase
total_d = round(total_l * d);      % Totale Laenge Delay Phase
total_s = round(total_l * s);



for t=1:total_a
    m1 = (max(x)/total_a);
    h(t) = m1*t;
end
for t=total_a+1:total_d
    m2 = (max(x)*ed - max(x))/(total_d - total_a);
    b2 = -m2*total_d + max(x)*ed;
    h(t) = m2*t + b2;
end
for t=total_d+1:total_s
    m3 = (max(x)*es - max(x)*ed)/(total_s - total_d);
    b3 = -m3*total_s + max(x)*es;
    h(t) = m3*t + b3;
end
for t=total_s+1:total_l
    m4 = (0 - max(x)*es)/(total_l - total_s);
    b4 = -m4*(total_s + 1) + max(x)*es;
    h(t) = m4*t + b4;
end

y = h .* x;

end

