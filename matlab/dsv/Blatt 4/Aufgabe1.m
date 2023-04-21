%% Signalsynthese
fs = 8192;                 % Abtastfrequenz [Hz]
n  = 0:((fs*1)-1);         % Zeitschritte

% Grundschwingung, 1. Harmonische
f1 = 500;                  % Frequenz [Hz]
s1 = 1 * sin(2 * pi * f1 * n * (1/fs));

% 1. Oberschwingung, 2. Harmonische
f2 = 1000;                 % Frequenz [Hz]
s2 = 0.5 * sin(2 * pi * f2 * n * (1/fs));

% 2. Oberschwingung, 3. Harmonische
f3 = 1500;                 % Frequenz [Hz]
s3 = 0.2 * sin(2 * pi * f3 * n * (1/fs));

% Synthetisiertes Signal
s4 = s1 + s2 + s3;


%% Plot aller Signale
subplot(4, 1, 1);
plot(s1);
xlabel('t');
ylabel('S1(t)');

subplot(4, 1, 2);
plot(s2);
xlabel('t');
ylabel('S2(t)');

subplot(4, 1, 3);
plot(s3);
xlabel('t');
ylabel('S3(t)');

subplot(4, 1, 4);
plot(s4);
xlabel('t');
ylabel('S4(t)');


%% Wiedergabe
soundsc(s1, fs);
pause(1);
soundsc(s2, fs);
pause(1);
soundsc(s3, fs);
pause(1);
soundsc(s4, fs);
