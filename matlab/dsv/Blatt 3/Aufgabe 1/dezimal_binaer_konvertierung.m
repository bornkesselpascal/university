% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 3, Aufgabe 1

function output = dezimal_binaer_konvertierung(input)

nbr = int32(input);
res = '';

if(nbr == 0)
    % Null
    output = '0';
elseif(nbr > 0)
    % Positive Integers
    while nbr > 0
        if mod(nbr, 2) == 1
            res = [res, '1'];
        else
            res = [res, '0'];
        end
        nbr = idivide(nbr, int32(2), "floor");
    end

    output = fliplr(res);
else
    % Negative Integers
    error("Diese Funktion ist nicht für negative Zahlen implementiert.");
end

end
