% Praktikum 8Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 6, Aufgabe 2 (Teilaufgabe a)

%% Erzeugung des Signals S7
Fs = 8192;               % Abtastfrequenz
T = 1/Fs;                % Abtastperiode
N = 8192;                % Signallaenge

t = (0:N-1);
S4 = (1 * sin(2 * pi * 500 * t * (1/Fs))) + (0.5 * sin(2 * pi * 1000 * t * (1/Fs))) + (0.2 * sin(2 * pi * 1500 * t * (1/Fs)));
S7 = S4 + (5    * randn(1, N));

%% Bearbeitung im Frequenzraum
limit_amplitude = 0.3;

S7_fft = fft(S7);
S8_fft = zeros(1,numel(S7_fft));

for idx = 1:numel(S7_fft)
    current_amplitude = 2*abs(S7_fft(idx)/N);
    if current_amplitude >= limit_amplitude
        S8_fft(idx) = S7_fft(idx);
    end
end

S8 = ifft(S8_fft);

% Plotten des Signals
subplot(3,1,1);
plot(S4);
title('Signal S4')
xlabel('n')
ylabel('S[n]')

subplot(3,1,2);
plot(S7);
title('Signal S7')
xlabel('n')
ylabel('S[n]')

subplot(3,1,3);
plot(S8);
title('Signal S8')
xlabel('n')
ylabel('S[n]')

% Wiedergabe des Signals
soundsc(S4, Fs);
pause(1);
soundsc(S7, Fs);
pause(1);
soundsc(S8, Fs);
pause(1);
