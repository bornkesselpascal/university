% Praktikum Matlab
% Pascal Julian Bornkessel, FFI 6
% Blatt 3, Aufgabe 1

function output = binaer_dezimal_konvertierung(input)

nbr = fliplr(input);
res = 0;

for cnt = 1:length(nbr)
    if nbr(cnt) == '1'
        res = res + power(2, cnt-1);
    end
end

output = res;

end
