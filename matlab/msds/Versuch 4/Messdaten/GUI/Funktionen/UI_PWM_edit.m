function UI_PWM_edit(src,evt,UI)

PWM_max = 100;
PWM_min = -100;

String = src.String;
String = strrep(String,',','.');
Wert = str2double(String);

if isnan(Wert)
    src.String = num2str(src.UserData);
elseif Wert > PWM_max
    Wert = PWM_max;
    src.UserData = PWM_max;
    src.String = num2str(PWM_max);
elseif Wert < PWM_min
    Wert = PWM_min;
    src.UserData = PWM_min;
    src.String = num2str(PWM_min);
else
    Wert = round(Wert,0);
    src.UserData = round(Wert,0);
    src.String = num2str(src.UserData);
end

clear String Wert PWM_max PWM_min

end