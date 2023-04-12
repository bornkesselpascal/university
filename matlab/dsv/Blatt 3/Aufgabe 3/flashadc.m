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

res_com = zeros(length(u_x), (2.^bit - 1));

% Schleife mit jedem Wert des Signalvektors
for index = 1:length(u_x)
    value = u_x(index);

    % Vergleich des aktuellen Wertes mit den Referenzspannungen
    for comparator = 1:(2^bit - 1)
        u_k = spannungsteiler(u_r, comparator, (2.^bit));
        res_com(index, comparator) = komparator(value, u_k, u_cc, u_ee);
    end
end


res_sum = sum(res_com, 2);
gray_output = '';

% Encoder
for index = 1:length(res_sum)
    tmp_binaer = dezimal_binaer_konvertierung(res_sum(index));
    tmp_gray   = binaer_gray_konvertierung(tmp_binaer);

    while length(tmp_gray) < bit
        tmp_gray = ['0', tmp_gray];
    end

    gray_output = [gray_output; tmp_gray];
end

end

