% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 2, Aufgabe II.1

tonleiter0 = Aufgabe2_Tonleiter(220);
tonleiter1 = Aufgabe2_Tonleiter(440);
tonleiter2 = Aufgabe2_Tonleiter(880);

dauer = 0.25;

% Plot
sub1 = subplot(2,1,2);
cla(sub1);
q = animatedline(sub1, 'Color', 'r');
sub2 = subplot(2,1,1);
cla(sub2);
s = animatedline(sub2, 'Color', 'b');
count = 0;

% Stück 1 ----------
count = Aufgabe2_PlaySound(tonleiter1.c, dauer,s, q, count);
count = Aufgabe2_PlaySound(tonleiter1.d, dauer,s,  q, count);
count = Aufgabe2_PlaySound(tonleiter1.e, dauer,s,  q, count);
count = Aufgabe2_PlaySound(tonleiter1.f, dauer,s,  q, count);
for i = 1:2
    count = Aufgabe2_PlaySound(tonleiter1.g, dauer*1.5, s, q, count);
end
for i = 1:2
    for j = 1:4
        count = Aufgabe2_PlaySound(tonleiter2.a, dauer, s, q, count);
    end
    count = Aufgabe2_PlaySound(tonleiter1.g, dauer*2, s, q, count);
end
for i = 1:4
    count = Aufgabe2_PlaySound(tonleiter1.f, dauer, s, q, count);
end
for i = 1:2
    count = Aufgabe2_PlaySound(tonleiter1.e, dauer*1.5, s, q, count);
end
for i = 1:4
    count = Aufgabe2_PlaySound(tonleiter1.g, dauer, s, q, count);
end
Aufgabe2_PlaySound(tonleiter1.c, dauer*1.5, s, q, count);
