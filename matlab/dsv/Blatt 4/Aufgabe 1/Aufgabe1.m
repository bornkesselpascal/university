fs = 8192;                 % Abtastfrequenz [Hz]
n  = 0:(fs-1);             % Zeitschritte


f1 = 500;                  % Frequenz [Hz]
s1 = 2 * sin(2 * pi * f1 * n * (1/fs));

f2 = 1000;                 % Frequenz [Hz]
s2 = 1 * sin(2 * pi * f2 * n * (1/fs));

f3 = 1500;                 % Frequenz [Hz]
s3 = 0.4 * sin(2 * pi * f3 * n * (1/fs));

s4 = s1 + s2 + s3;

soundsc(s1, fs);
pause(1);
soundsc(s2, fs);
pause(1);
soundsc(s3, fs);
pause(1);
soundsc(s4, fs);

