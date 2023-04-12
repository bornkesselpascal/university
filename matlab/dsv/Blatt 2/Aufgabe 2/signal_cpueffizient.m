% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 2, Aufgabe II.2

function s = signal_cpueffizient(n)

persistent values
if isempty(values)
    values = [0 40 80 120 160 200 240 280 320 360 400 400 400 400 400 400 400 400 400 400 400 360 320 280 240 200 160 120 80 40 0 -40 -80 -120 -160 -200 -240 -280 -320 -360 -400 -400 -400 -400 -400 -400 -400 -400 -400 -400 -400 -360 -320 -280 -240 -200 -160 -120 -80 -40];
end

k = mod(n, 60);
s = values(k+1);

end