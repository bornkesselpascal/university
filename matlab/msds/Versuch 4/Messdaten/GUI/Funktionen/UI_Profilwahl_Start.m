function UI_Profilwahl_Start(src,evt,UI)

    if (src.Value == 1)
        src.UserData = 1;
        src.Enable = 'off';
        UI.Profilwahl_Stop.Enable = 'on';
        % Wenn ein Profil abgefahren wird, soll PWM-Ausgabe nicht möglich
        % sein
        UI.PWM_edit.Enable = 'off';
        UI.PWM_send.Enable = 'off';
        UI.PWM_send.UserData = 2;
    end

end