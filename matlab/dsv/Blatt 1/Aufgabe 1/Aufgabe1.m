% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 1, Aufgabe II.1


t   =(0:.001:1)';           % Zeit in [s]
x0  = 1;                    % Amplitude
f0  = 4;                    % Grundfrequenz in [Hz]
x_t = x0*sin(2*pi*f0*t);

n   = 1:64;                 % Diskrete Zeitschritte
fs  = 64;                   % Abtastfrequenz in [Hz]
Ts  = 1/fs;                 % Abtastintervall in [s]
x_n = x0*sin(2*pi*f0*n*Ts);

Ts1 = 1/(16*f0);
Ts2 = 1/(f0);
x_n1 = x0*sin(2*pi*f0*n*Ts1);
x_n2 = x0*sin(2*pi*f0*n*Ts2);


tiledlayout(3,2)

nexttile
plot(t, x_t)
title('Darstellung mit plot()')
xlabel('t')
ylabel('x[t]')

nexttile
stem(t, x_t)
title('Darstellung mit stem()')
xlabel('t')
ylabel('x[t]')

nexttile
plot(n, x_n1)
title('Ts = 1/(16 * f0)')
xlabel('n')
ylabel('x[n]')
xlim([1 64])

nexttile
stem(n, x_n1)
title('Ts = 1/(16 * f0)')
xlabel('n')
ylabel('x[n]')
xlim([1 64])

nexttile
plot(n, x_n2)
title('Ts = 1/f0')
xlabel('n')
ylabel('x[n]')
xlim([1 64])

nexttile
stem(n, x_n2)
title('Ts = 1/f0')
xlabel('n')
ylabel('x[n]')
xlim([1 64])