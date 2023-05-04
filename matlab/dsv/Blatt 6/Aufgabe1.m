% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 6, Aufgabe 1

%% Erzeugung des Signals S7
Fs = 8192;               % Abtastfrequenz
T = 1/Fs;                % Abtastperiode
N = 8192;                % Signallaenge

t = (0:N-1);
S4 = (1 * sin(2 * pi * 500 * t * (1/Fs))) + (0.5 * sin(2 * pi * 1000 * t * (1/Fs))) + (0.2 * sin(2 * pi * 1500 * t * (1/Fs)));
S7 = S4 + (5    * randn(1, N));

%% Berechnung der Filter-Koeffizienten
M = 40;                  % Ordnung
Fc = 800;                % Cut-Off-Frequenz
wc = 2 * pi * (Fc/Fs);   % Nyquist-normierte Cut-Off-Frequenz

h = (wc/pi) * sinc((wc * (2*(0:M) - M))/(2 * pi));

%% Gewichtung mit Hamming-Fenster
w = 0.54 - (0.46 * cos((2*pi*(0:M))/M));
firfilter = h .* w;

%% Faltung mit firfilter
S7_filtered = conv(S7, firfilter, "same");

%% Diskrete Fourier-Transformation
S7_fft = fft(S7);
S7_filtered_fft = fft(S7_filtered);
P2_S7_fft = abs(S7_fft/N);
P2_S7_filtered_fft = abs(S7_filtered_fft/N);
P1_S7_fft = P2_S7_fft(1:N/2+1);
P1_S7_fft(2:end-1) = 2*P1_S7_fft(2:end-1);
P1_S7_filtered_fft = P2_S7_filtered_fft(1:N/2+1);
P1_S7_filtered_fft(2:end-1) = 2*P1_S7_filtered_fft(2:end-1);

%% Darstellung
subplot(2,1,1);
stem(0:N/2,P1_S7_fft)
xlim([0 N/2]);
title('Einseitiges Spektrum von S7(t) [unverändert]')
xlabel('f (Hz)')
ylabel('|P(f)|')

subplot(2,1,2);
stem(0:N/2,P1_S7_filtered_fft)
xlim([0 N/2]);
title('Einseitiges Spektrum von S7(t) [FIR-gefiltert]')
xlabel('f (Hz)')
ylabel('|P(f)|')
