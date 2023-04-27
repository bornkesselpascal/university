function UI_Profilwahl_Stop(src,evt,UI)

    if (src.Value == 1)
        src.UserData = 1;
        src.Enable = 'off';
        UI.Profilwahl_Start.UserData = 0;
        UI.Profilwahl_Start.Enable = 'on';
        % Wenn ein Profil abgebrochen wird, soll PWM-Ausgabe wieder möglich
        % sein
        UI.PWM_edit.Enable = 'on';
        UI.PWM_send.Enable = 'on';
    end

end