function UI_Synchro_edit(src,evt,UI)

Synchro_max = 800;
Synchro_min = 0;

String = src.String;
String = strrep(String,',','.');
Wert = str2double(String);

if isnan(Wert)
    src.String = num2str(src.UserData);
elseif Wert > Synchro_max
    Wert = Synchro_max;
    src.UserData = Synchro_max;
    src.String = num2str(Synchro_max);
elseif Wert < Synchro_min
    Wert = Synchro_min;
    src.UserData = Synchro_min;
    src.String = num2str(Synchro_min);
else
    Wert = round(Wert,0);
    src.UserData = round(Wert,0);
    src.String = num2str(src.UserData);
end

clear String Wert Synchro_max Synchro_min

end