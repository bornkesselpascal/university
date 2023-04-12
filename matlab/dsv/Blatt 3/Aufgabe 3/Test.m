% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 3, Aufgabe 3

u_x = audioread('fadc_short.wav');


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

    u_r(index) = tmp_dezimal/(2^bits - 1);
end


% Berechnung des Quantisierungsfehlers
error = u_x - u_r;

clf;
hold on
plot(t, u_x);
plot(t, u_r);
plot(t, error);
hold off

sound(u_r)
