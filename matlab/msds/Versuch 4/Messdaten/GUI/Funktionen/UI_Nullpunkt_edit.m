function UI_Nullpunkt_edit(src,evt,UI)

Nullpunkt_max = 400;
Nullpunkt_min = 100;

String = src.String;
String = strrep(String,',','.');
Wert = str2double(String);

if isnan(Wert)
    src.String = num2str(src.UserData);
elseif Wert > Nullpunkt_max
    Wert = Nullpunkt_max;
    src.UserData = Nullpunkt_max;
    src.String = num2str(Nullpunkt_max);
elseif Wert < Nullpunkt_min
    Wert = Nullpunkt_min;
    src.UserData = Nullpunkt_min;
    src.String = num2str(Nullpunkt_min);
else
    Wert = round(Wert,0);
    src.UserData = round(Wert,0);
    src.String = num2str(src.UserData);
end

clear String Wert Synchro_max Synchro_min

end