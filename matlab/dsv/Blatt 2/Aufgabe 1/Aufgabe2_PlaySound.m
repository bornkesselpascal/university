% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 2, Aufgabe II.1

function count = Aufgabe2_PlaySound(frequenz,dauer,p, q, count)
fs = 4 * frequenz;         % Abtastfrequenz in [Hz]
n  = 1:(fs*dauer);         % Zeitschritte
x0 = 1;                    % Amplitude

s  = x0 * sin(2 * pi * frequenz * n * (1/fs));

h = huellkurve(0.15,0.25,0.9,0.9,0.7,s);

% Required for Plot
for i = 1:length(n)
    n_draw(i) = i + count;
end
count = count + length(n);

addpoints(p, n_draw, s);
addpoints(q, n_draw, h);
drawnow limitrate

soundsc(h, fs);
pause(dauer + 0.1);

end

