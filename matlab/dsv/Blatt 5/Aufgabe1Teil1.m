% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 5, Aufgabe 1 (Teilaufgabe a bis c)

Fs = 8192;               % Abtastfrequenz
T = 1/Fs;                % Abtastperiode
N = 8192;                % Signallaenge

Xre = zeros(1,N);
Xim = zeros(1,N);

%% Berechnung des Signals S4
t = (0:N-1);
S4 = (1 * sin(2 * pi * 500 * t * (1/Fs))) + (0.5 * sin(2 * pi * 1000 * t * (1/Fs))) + (0.2 * sin(2 * pi * 1500 * t * (1/Fs)));

%% DFT Berechnen
tStart_dft = tic;
for k = 1:N
    re_tmp = 0;
    im_tmp = 0;

    for n = 1:N            
        %% Realteil von DFT(x(k))
        re_tmp = re_tmp + S4(n) * cos(2*pi*(((k-1)*(n-1))/N));
 
        %% Imaginaerteil von DFT(x(k))
        im_tmp = im_tmp - S4(n) * sin(2*pi*(((k-1)*(n-1))/N));
    end
    Xre(k) = re_tmp;
    Xim(k) = im_tmp;
end
tEnd_dft = toc(tStart_dft)

%% FFT Berechnen
tStart_fft = tic;
Y_fft = fft(S4);
tEnd_fft = toc(tStart_fft)
    
%% Zweiseitiges normiertes Spektrum
P2_dft = 1/N * sqrt(Xre.*Xre + Xim.*Xim);
P2_fft = abs(Y_fft/N);
 
%% Einseitiges Spektrum
P1_dft = P2_dft(1:N/2+1);
P1_dft(2:end-1) = 2*P1_dft(2:end-1);
P1_fft = P2_fft(1:N/2+1);
P1_fft(2:end-1) = 2*P1_fft(2:end-1);
    
%% Ergebnisse Plotten
subplot(2,1,1);
stem(0:N/2,P1_dft)
xlim([0 N/2]);
title('Einseitiges Spektrum von S4(t) [eigene Berechnung]')
xlabel('f (Hz)')
ylabel('|P(f)|')

subplot(2,1,2);
stem(0:N/2,P1_fft)
xlim([0 N/2]);
title('Einseitiges Spektrum von S4(t) [Berechnung mit Funktion]')
xlabel('f (Hz)')
ylabel('|P(f)|')

