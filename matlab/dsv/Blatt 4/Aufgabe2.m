%% Signalsynthese (aus Aufgabe 1)
fs = 8192;                 % Abtastfrequenz [Hz]
size = (fs*1);
n  = 0:(size-1);         % Zeitschritte

s1 = 1 * sin(2 * pi * 500 * n * (1/fs));
s2 = 0.5 * sin(2 * pi * 1000 * n * (1/fs));
s3 = 0.2 * sin(2 * pi * 1500 * n * (1/fs));
s4 = s1 + s2 + s3;


%% Histogramm des Rauschvektors
noise = randn(1, size);

% Darstellung des Histogramm
subplot(3,1,1);
hist(noise, 1000);
xlabel('Zufallswerte');
ylabel('Anzahl');

% Autokorrelation
[corr, lags] = xcorr(noise);

subplot(3,1,2);
plot(lags, corr);
xlabel('Lag');
ylabel('Correlation');

% Erzeugung von noise2
noise2 = 3.5 + sqrt(5^2) * randn(1, size);

subplot(3,1,3);
hist(noise2, 1000);
xlabel('Zufallswerte');
ylabel('Anzahl');


%% Erzeugung der verrauschten Signale
noise_s5 = 0.01 * randn(1, size);
noise_s6 = 0.1  * randn(1, size);
noise_s7 = 5    * randn(1, size);

s5 = s4 + noise_s5;
s6 = s4 + noise_s6;
s7 = s4 + noise_s7;

% Berechnung des SNR
u_eff_s4 = rms(s4);
u_eff_n5 = rms(noise_s5);
u_eff_n6 = rms(noise_s6);
u_eff_n7 = rms(noise_s7);

SNR_s5 = 10 * log10((u_eff_s4^2)/(u_eff_n5^2));
SNR_s6 = 10 * log10((u_eff_s4^2)/(u_eff_n6^2));
SNR_s7 = 10 * log10((u_eff_s4^2)/(u_eff_n7^2));


%% Wiedergabe
soundsc(s4, fs);
pause(1);
soundsc(s5, fs);
pause(1);
soundsc(s6, fs);
pause(1);
soundsc(s7, fs);
