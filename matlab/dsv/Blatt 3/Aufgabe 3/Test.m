% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 3, Aufgabe 3

% Vor dem Ausführen bitte den Ornder Functions zum Pfad hinzufügen.
% Die Konvertierung der gesamten Datei dauert einige Minuten (~2).

u_x = audioread('fadc.wav');


% Wiedergabe des unveränderten Audiosignals
% sound(u_x);


% Digitalisierung des Audiosignals
bits = 3;

u_d = flashadc(u_x, 1, 1, 0, bits);

u_r = zeros(length(u_d), 1);
for index = 1:length(u_d)
    check = u_d(index, :);
    tmp_binaer = gray_binaer_konvertierung(u_d(index, :));
    tmp_dezimal = binaer_dezimal_konvertierung(tmp_binaer);

    u_r(index) = tmp_dezimal/(2^bits);
end


% Berechnung des Quantisierungsfehlers
error = u_x - u_r;

clf;
hold on
xlabel('t');
ylabel('u');
t = 1:length(u_r);
plot(t, u_x);
plot(t, u_r);
plot(t, error);
hold off

legend('u_x','u_r', 'error');

%sound(u_r)
