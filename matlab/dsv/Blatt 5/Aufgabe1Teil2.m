% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 5, Aufgabe 1 (Teilaufgabe d bis e)

Fs = 8192;               % Abtastfrequenz
T = 1/Fs;                % Abtastperiode
N = 8192;                % Signallaenge

%% Berechnung des Signals S4 und Erzeugung der verrauschten Signale
t = (0:N-1);
S4 = (1 * sin(2 * pi * 500 * t * (1/Fs))) + (0.5 * sin(2 * pi * 1000 * t * (1/Fs))) + (0.2 * sin(2 * pi * 1500 * t * (1/Fs)));
S5 = S4 + (0.01 * randn(1, N));
S6 = S4 + (0.1  * randn(1, N));
S7 = S4 + (5    * randn(1, N));

%% DFT Berechnen
Y_s4 = dft(N, S4);
Y_s5 = dft(N, S5);
Y_s6 = dft(N, S6);
Y_s7 = dft(N, S7);
    
%% Zweiseitiges normiertes Spektrum
P2_s4 = abs(Y_s4/N);
P2_s5 = abs(Y_s5/N);
P2_s6 = abs(Y_s6/N);
P2_s7 = abs(Y_s7/N);
 
%% Einseitiges Spektrum
P1_s4 = P2_s4(1:N/2+1);
P1_s4(2:end-1) = 2*P1_s4(2:end-1);
P1_s5 = P2_s5(1:N/2+1);
P1_s5(2:end-1) = 2*P1_s5(2:end-1);
P1_s6 = P2_s6(1:N/2+1);
P1_s6(2:end-1) = 2*P1_s6(2:end-1);
P1_s7 = P2_s7(1:N/2+1);
P1_s7(2:end-1) = 2*P1_s7(2:end-1);

%% iDFT (Inverse) Berechnen
inv_s5 = dft_inverse(N, Y_s5);
inv_s6 = dft_inverse(N, Y_s6);
inv_s7 = dft_inverse(N, Y_s7);
    
%% Ergebnisse Plotten
subplot(4,2,1);
stem(0:N/2,P1_s4)
xlim([0 N/2]);
title('Einseitiges Spektrum von S4(t) [Berechnung mit Funktion]')
xlabel('f (Hz)')
ylabel('|P(f)|')

subplot(4,2,2);
plot(S4);
title('Signal S4')
xlabel('n')
ylabel('S[n]')
legend('Original')

subplot(4,2,3);
stem(0:N/2,P1_s5)
xlim([0 N/2]);
title('Einseitiges Spektrum von S5(t) [Berechnung mit Funktion]')
xlabel('f (Hz)')
ylabel('|P(f)|')

subplot(4,2,4);
plot(S5);
hold on
plot(real(inv_s5))
hold off
title('Signal S5')
xlabel('n')
ylabel('S[n]')
legend('Original','InverseDFT')

subplot(4,2,5);
stem(0:N/2,P1_s6)
xlim([0 N/2]);
title('Einseitiges Spektrum von S6(t) [Berechnung mit Funktion]')
xlabel('f (Hz)')
ylabel('|P(f)|')

subplot(4,2,6);
plot(S6);
hold on
plot(real(inv_s6))
hold off
title('Signal S6')
xlabel('n')
ylabel('S[n]')
legend('Original','InverseDFT')

subplot(4,2,7);
stem(0:N/2,P1_s7)
xlim([0 N/2]);
title('Einseitiges Spektrum von S7(t) [Berechnung mit Funktion]')
xlabel('f (Hz)')
ylabel('|P(f)|')

subplot(4,2,8);
plot(S7);
hold on
plot(real(inv_s7))
hold off
title('Signal S7')
xlabel('n')
ylabel('S[n]')
legend('Original','InverseDFT')

function Ft = dft(N,signal)
% Berechnet die inverse eines DFT
Ft = zeros(1,N);

for k = 1:N
    for n = 1:N
        Ft(k) = Ft(k) + (signal(n) .* cos(2*pi*(((k-1)*(n-1))/N)) - i *signal(n) .* sin(2*pi*(((k-1)*(n-1))/N)));
    end
end

end

function Inv = dft_inverse(N,signal)
% Berechnet die inverse eines DFT
Inv = zeros(1,N);

for k = 1:N
    for n = 1:N
        Inv(k) = Inv(k) + (signal(n) .* cos(2*pi*(((k-1)*(n-1))/N)) + i *signal(n) .* sin(2*pi*(((k-1)*(n-1))/N)));
    end
end

Inv = 1/N * Inv;

end

