fs = 8192;                 % Abtastfrequenz [Hz]
n  = 0:(fs-1);             % Zeitschritte


f1 = 500;                  % Frequenz [Hz]
s1 = 1 * sin(2 * pi * f1 * n * (1/fs));

f2 = 1000;                 % Frequenz [Hz]
s2 = 0.5 * sin(2 * pi * f2 * n * (1/fs));

f3 = 1500;                 % Frequenz [Hz]
s3 = 0.2 * sin(2 * pi * f3 * n * (1/fs));

s4 = s1 + s2 + s3;

%% Aufgabe 2

% ToDo - Achsenbeschriftung, Doku, mehrere Plots

noise = randn(1, fs);
hist(noise, 1000);
xlabel('Wert');
ylabel('Anzahl');

autocorr_noise = xcorr(noise, noise);
plot(autocorr_noise);
xlabel('tau');
ylabel('r_noise (tau)');

myh = 3.5;
omega = 5;
noise2 = myh + sqrt(omega^2) * randn(1, fs);
hist(noise, 1000);
xlabel('Wert');
ylabel('Anzahl');

noise_tmp = randn(1, fs);
noise_s5 = (0.01/rms(noise_tmp)) * noise_tmp;
noise_s6 = (0.1/rms(noise_tmp)) * noise_tmp;
noise_s7 = (5/rms(noise_tmp)) * noise_tmp;

s5 = s4 + noise_s5;
s6 = s4 + noise_s6;
s7 = s4 + noise_s7;

u_eff_s4 = rms(s4);
u_eff_n5 = rms(noise_s5);
u_eff_n6 = rms(noise_s6);
u_eff_n7 = rms(noise_s7);

SNR_s5 = 10 * log((u_eff_s4^2)/(u_eff_n5^2));
SNR_s6 = 10 * log((u_eff_s4^2)/(u_eff_n6^2));
SNR_s7 = 10 * log((u_eff_s4^2)/(u_eff_n7^2));

soundsc(s5, fs);
pause(1);
soundsc(s6, fs);
pause(1);
soundsc(s7, fs);
pause(1);


