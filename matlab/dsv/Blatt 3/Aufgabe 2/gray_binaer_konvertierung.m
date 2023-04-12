% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 3, Aufgabe 2

function output = gray_binaer_konvertierung(input)

output = '';

% Übernahme des Most Significant Bit
output = [output, input(1)];

for cnt = 2:length(input)
    if xor(char_2_logical(output(cnt-1)), char_2_logical(input(cnt))) == false
        output = [output, '0'];
    else
        output = [output, '1'];
    end
end

end

