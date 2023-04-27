function UI_PWM_send(src,evt,board,UI,timer_data,COM_available)

global Status

if (src.Value == 1)
    src.UserData = 1;
    src.String = "stoppen";
    %Status_hold Buttons zurücksetzen
    UI.Status_hold_Button0.Value = 0;
    UI.Status_hold_Button1.Value = 0;
    UI.Status_hold_Button2.Value = 0;
    UI.Status_hold_Button3.Value = 0;
    UI.Status_hold_Button4.Value = 0;
    UI.Status_hold_Button5.Value = 0;
    UI.Status_hold_Button6.Value = 0;
    UI.Status_hold_Button7.Value = 0;
    UI.Status_hold_Button_Text.UserData = length(Status);
    % Wenn ein PWM-Wert ausgegeben wird, soll keine Profilwahl möglich sein
    UI.Profilwahl.Enable = 'off';
    UI.Profilwahl_Start.Enable = 'off';
    UI.Profilwahl_Start.UserData = 2;
else
    src.UserData = 0;
    src.String = "ausgeben";
    % Wenn kein PWM-Wert ausgegeben wird, soll eine Profilwahl möglich sein
    UI.Profilwahl.Enable = 'on';
    UI.Profilwahl_Start.Enable = 'on';
end