% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 5, Aufgabe 1 (Teilaufgabe d bis e)

teilaufgabe_e = true;


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
Y_s4 = fft(S4);
Y_s5 = fft(S5);
Y_s6 = fft(S6);
Y_s7 = fft(S7);
    
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
if teilaufgabe_e
    P1_I_s5 = dft_inverse(N, Y_s5);
    P1_I_s6 = dft_inverse(N, Y_s6);
    P1_I_s7 = dft_inverse(N, Y_s7);
end
    
%% Ergebnisse Plotten
subplot(4,1,1);
stem(0:N/2,P1_s4)
xlim([0 N/2]);
title('Einseitiges Spektrum von S4(t) [Berechnung mit Funktion]')
xlabel('f (Hz)')
ylabel('|P(f)|')

subplot(4,1,2);
stem(0:N/2,P1_s5)
if teilaufgabe_e
    hold on
    stem(0:N/2,P1_I_s5)
    hold off
end
xlim([0 N/2]);
title('Einseitiges Spektrum von S5(t) [Berechnung mit Funktion]')
xlabel('f (Hz)')
ylabel('|P(f)|')

subplot(4,1,3);
stem(0:N/2,P1_s6)
if teilaufgabe_e
    hold on
    stem(0:N/2,P1_I_s6)
    hold off
end
xlim([0 N/2]);
title('Einseitiges Spektrum von S6(t) [Berechnung mit Funktion]')
xlabel('f (Hz)')
ylabel('|P(f)|')

subplot(4,1,4);
stem(0:N/2,P1_s7)
if teilaufgabe_e
    hold on
    stem(0:N/2,P1_I_s7)
    hold off
end
xlim([0 N/2]);
title('Einseitiges Spektrum von S7(t) [Berechnung mit Funktion]')
xlabel('f (Hz)')
ylabel('|P(f)|')


function P1_inv = dft_inverse(N,signal)
% Berechnet die inverse eines DFT und gibt das einseitige Spektrum zurück

idft = zeros(1,N);

for k = 1:N
    re_tmp = 0;
    im_tmp = 0;

    for n = 1:N            
        %% Realteil von DFT(x(k))
        re_tmp = re_tmp + signal(n) * cos(2*pi*(((k-1)*(n-1))/N));
 
        %% Imaginaerteil von DFT(x(k))
        im_tmp = im_tmp + signal(n) * sin(2*pi*(((k-1)*(n-1))/N));
    end
    idft(k) = ((1/N) * re_tmp) + ((1/N) * im_tmp);
end

P2_inv = abs(idft); % idft/N???
P1_inv = P2_inv(1:N/2+1);
P1_inv(2:end-1) = 2*P1_inv(2:end-1);
end
