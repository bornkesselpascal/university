% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 6, Aufgabe 2

%% Erzeugung des Signals S7
Fs = 8192;               % Abtastfrequenz
T = 1/Fs;                % Abtastperiode
N = 8192;                % Signallaenge

t = (0:N-1);
S4 = (1 * sin(2 * pi * 500 * t * (1/Fs))) + (0.5 * sin(2 * pi * 1000 * t * (1/Fs))) + (0.2 * sin(2 * pi * 1500 * t * (1/Fs)));
S7 = S4 + (5    * randn(1, N));



%% Bearbeitung im Frequenzraum (Teilaufgabe A)
limit_amplitude = 0.4;

S7_fft = fft(S7);
S8_fft = zeros(1,numel(S7_fft));

for idx = 1:numel(S7_fft)
    current_amplitude = 2*abs(S7_fft(idx)/N);
    if current_amplitude >= limit_amplitude
        S8_fft(idx) = S7_fft(idx);
    end
end

S8 = ifft(S8_fft);



%% Entwurf der Koeffizienten (Teilaufgabe B)
M_b = 40;

w_b = 0.54 - (0.46 * cos((2*pi*(0:M_b))/M_b));

% Bandpass für 500 Hz
h_500_1_b = tiefpass_koeffizienten(M_b, 490, Fs);
h_500_2_b = tiefpass_koeffizienten(M_b, 510, Fs);
h_500_b = (h_500_2_b - h_500_1_b) .* w_b;

% Bandpass für 1000 Hz
h_1000_1_b = tiefpass_koeffizienten(M_b, 990, Fs);
h_1000_2_b = tiefpass_koeffizienten(M_b, 1010, Fs);
h_1000_b = (h_1000_2_b - h_1000_1_b) .* w_b;

% Bandpass für 1500 Hz
h_1500_1_b = tiefpass_koeffizienten(M_b, 1490, Fs);
h_1500_2_b = tiefpass_koeffizienten(M_b, 1510, Fs);
h_1500_b = (h_1500_2_b - h_1500_1_b) .* w_b;

% Parallelschaltung der Bandpassfilter
h_b = h_500_b + h_1000_b + h_1500_b;
plot(20*log10(abs(fft(h_b, N))))

% Anwendung im Frequenzbereich
S9_fft = fft(S7, N) .* fft(h_b, N);
S9 = ifft(S9_fft);



%% Entwurf der Koeffizienten (Teilaufgabe C)
M_c = 400;
d = 10;

w_c = 0.54 - (0.46 * cos((2*pi*(0:M_c))/M_c));

% Bandpass für 500 Hz
h_500_1_c = tiefpass_koeffizienten(M_c, (500-(d/2)), Fs);
h_500_2_c = tiefpass_koeffizienten(M_c, (500+(d/2)), Fs);
h_500_c = (h_500_2_c - h_500_1_c) .* w_c;
h_500_norm_c = real(ifft(fft(h_500_c)/max(fft(h_500_c))));

% Bandpass für 1000 Hz
h_1000_1_c = tiefpass_koeffizienten(M_c, (1000-(d/2)), Fs);
h_1000_2_c = tiefpass_koeffizienten(M_c, (1000+(d/2)), Fs);
h_1000_c = (h_1000_2_c - h_1000_1_c) .* w_c;
h_1000_norm_c = real(ifft(fft(h_1000_c)/max(fft(h_1000_c))));

% Bandpass für 1500 Hz
h_1500_1_c = tiefpass_koeffizienten(M_c, (1500-(d/2)), Fs);
h_1500_2_c = tiefpass_koeffizienten(M_c, (1500+(d/2)), Fs);
h_1500_c = (h_1500_2_c - h_1500_1_c) .* w_c;
h_1500_norm_c = real(ifft(fft(h_1500_c)/max(fft(h_1500_c))));

% Parallelschaltung der Bandpassfilter
h_c = h_500_norm_c + h_1000_norm_c + h_1500_norm_c;
plot(20*log10(abs(fft(h_c, N))))

% Anwendung im Frequenzbereich
S10_fft = fft(S7, N) .* fft(h_c, N);
S10 = ifft(S10_fft);



%% Plotten der Signalspekren
subplot(5,1,1);
stem(0:N/2,einseitiges_spektrum(S4,N))
xlim([0 N/2]);
title('Vergleich der Spektren von S4, S7 und S8')
hold on
stem(0:N/2,einseitiges_spektrum(S7,N))
stem(0:N/2,einseitiges_spektrum(S8,N))
hold off
xlabel('f (Hz)')
ylabel('|P(f)|')
legend('S4','S7','S8')

subplot(5,1,2);
plot(S4)
xlim([0 250]);
ylim([-1.5 1.5]);
title('Vergleich der Signale von S4, S7 und S8')
hold on
plot(S7)
plot(S8)
hold off
xlabel('n')
ylabel('S[n]')
legend('S4','S7','S8')

subplot(5,1,3);
stem(0:N/2,einseitiges_spektrum(S4,N))
xlim([0 N/2]);
title('Vergleich der Spektren von S4, S7 und S9')
hold on
stem(0:N/2,einseitiges_spektrum(S7,N))
stem(0:N/2,einseitiges_spektrum(S9,N))
hold off
xlabel('f (Hz)')
ylabel('|P(f)|')
legend('S4','S7','S9')

subplot(5,1,4);
stem(0:N/2,einseitiges_spektrum(S9,N))
xlim([0 N/2]);
title('Einsietiges Spektrum von S9')
xlabel('f (Hz)')
ylabel('|P(f)|')
legend('S9')

subplot(5,1,5);
stem(0:N/2,einseitiges_spektrum(S7,N))
xlim([0 N/2]);
title('Vergleich der Spektren von S7, S8, S9 und S10')
hold on
stem(0:N/2,einseitiges_spektrum(S8,N))
stem(0:N/2,einseitiges_spektrum(S9,N))
stem(0:N/2,einseitiges_spektrum(S10,N))
hold off
xlabel('f (Hz)')
ylabel('|P(f)|')
legend('S7','S8','S9','S10')


%% Wiedergabe der Signale
soundsc(S4, Fs);
pause(1);
soundsc(S7, Fs);
pause(1);
soundsc(S8, Fs);
pause(1);
soundsc(S9, Fs);
pause(1);
soundsc(S10, Fs);
pause(1);


function h = tiefpass_koeffizienten(M,Fc,Fs)
    wc = 2 * pi * (Fc/Fs);
    h = (wc/pi) * sinc((wc * (2*(0:M) - M))/(2 * pi));
end

function P1_fft = einseitiges_spektrum(signal, N)
    Y_fft = fft(signal);
    
    % Zweiseitiges normiertes Spektrum
    P2_fft = abs(Y_fft/N);
    
    % Einseitiges Spektrum
    P1_fft = P2_fft(1:N/2+1);
    P1_fft(2:end-1) = 2*P1_fft(2:end-1);
end