% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 3, Aufgabe 3

function gray_output = flashadc(u_x, u_r, u_cc, u_ee, bit)
% u_x:         Pseudo-analoges Eingangssignal (Audiosignal) [Zeilenvektor]
% u_r:         Referenzspannung                             [Skalar]
% u_cc:        positive Versorgungsspannung                 [Skalar]
% u_ee:        negative Versorgungsspannung                 [Skalar]
% bit:         Auflösung des A/D Wandlers in Bit            [Skalar]
% gray_output: Gray-codiertes Ausgangssignal                [Zeilenvektor]

gray_output = '';

% Berechnung der Widerstände
u_k = zeros((2^bit - 1), 1);
for comparator = 1:(2^bit - 1)
    u_k(comparator) = spannungsteiler(u_r, comparator, (2.^bit));
end

% Schleife mit jedem Wert des Signalvektors
for index = 1:length(u_x)
    value = u_x(index);
    sum = 0;

    % Vergleich des aktuellen Wertes mit den Referenzspannungen
    for comparator = 1:(2^bit - 1)
        com = komparator(value, u_k(comparator), u_cc, u_ee);
        if com == 0
            break
        end

        sum = sum + com;
    end

    % Encoder
    tmp_gray   = binaer_gray_konvertierung(dezimal_binaer_konvertierung(sum));
    while length(tmp_gray) < bit
        tmp_gray = ['0', tmp_gray];
    end

    gray_output = [gray_output; tmp_gray];
end

end

