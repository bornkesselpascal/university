% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 2, Aufgabe II.2

function s = signal_speichereffizient(n)

if mod(n, 60)<10
    s = 40*mod(n, 60);
elseif mod(n, 60)<=20
    s = 400;
elseif mod(n, 60)<40
    s = -40*mod(n, 60) + 1200;
elseif mod(n, 60)<=50
    s = -400;
else
    s = 40*mod(n, 60) - 2400;
end

end

