% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 3, Aufgabe 2 - Support-Funktion

function output = char_2_logical(input)

% Umwandlung der Character '0' und '1' in true und flase zur korrekten
% Benutzung von XOR.

if input == '0'
    output = false;
elseif input == '1'
    output = true;
else
    error("Input is not '0' or '1'.");
end

end

