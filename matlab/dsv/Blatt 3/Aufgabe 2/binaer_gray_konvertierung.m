% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 3, Aufgabe 2

function output = binaer_gray_konvertierung(input)

output = '';

% Übernahme des Most Significant Bit
output = [output, input(1)];

for cnt = 2:length(input)
    if xor(char_2_logical(input(cnt)), char_2_logical(input(cnt-1))) == false
        output = [output, '0'];
    else
        output = [output, '1'];
    end
end

end

