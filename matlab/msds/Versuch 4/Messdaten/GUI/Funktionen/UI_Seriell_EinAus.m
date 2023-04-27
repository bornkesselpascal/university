function UI_Seriell_EinAus(src,evt,board,UI,Achse,timer_data,timer_send,COM_available)

    global Zeit x_lin x_rot v_lin v_rot a a_x a_z Strom Spannung Ansteuerung_EM
        
    %Interpolations-Checkbox, Speichern-Toggle-Button und PWM-Eingaben aktivieren
    if (src.Value == 1)
        UI.Speichern_EinAus.Enable = 'on';
        UI.PWM_text.Enable = 'on';
        UI.PWM_edit.Enable = 'on';
        UI.PWM_send.Enable = 'on';
        UI.Profilwahl_text.Enable = 'on';
        UI.Profilwahl.Enable = 'on';
        UI.Profilwahl_Start.Enable = 'on';
        UI.Nullpunkt_text.Enable = 'on';
        UI.Nullpunkt_edit.Enable = 'on';
        UI.Synchro_text.Enable = 'on';
        UI.Synchro_edit.Enable = 'on';
        UI.Synchro_new.Enable = 'on';
        UI.Status_Button_Text.Enable = 'on';
        UI.Status_Button0.Enable = 'inactive';
        UI.Status_Button1.Enable = 'inactive';
        UI.Status_Button2.Enable = 'inactive';
        UI.Status_Button3.Enable = 'inactive';
        UI.Status_Button4.Enable = 'inactive';
        UI.Status_Button5.Enable = 'inactive';
        UI.Status_Button6.Enable = 'inactive';
        UI.Status_Button7.Enable = 'inactive';
        UI.Status_hold_Button_Text.Enable = 'on';
        UI.Status_hold_Button0.Enable = 'inactive';
        UI.Status_hold_Button1.Enable = 'inactive';
        UI.Status_hold_Button2.Enable = 'inactive';
        UI.Status_hold_Button3.Enable = 'inactive';
        UI.Status_hold_Button4.Enable = 'inactive';
        UI.Status_hold_Button5.Enable = 'inactive';
        UI.Status_hold_Button6.Enable = 'inactive';
        UI.Status_hold_Button7.Enable = 'inactive';
        %Durch Neuaktivierung der seriellen Kommunikation wird auf dem
        %Arduino ein Reset ausgelöst --> Abtastzeit wird auf 100ms
        %festgelegt
    elseif (src.Value == 0)
        UI.Speichern_EinAus.Enable = 'off';
        UI.PWM_text.Enable = 'off';
        UI.PWM_edit.Enable = 'off';
        UI.PWM_send.Enable = 'off';
        UI.Profilwahl_text.Enable = 'off';
        UI.Profilwahl.Enable = 'off';
        UI.Profilwahl_Start.Enable = 'off';
        UI.Nullpunkt_text.Enable = 'off';
        UI.Nullpunkt_edit.Enable = 'off';
        UI.Synchro_text.Enable = 'off';
        UI.Synchro_edit.Enable = 'off';
        UI.Synchro_new.Enable = 'off';
        UI.Status_Button_Text.Enable = 'off';
        UI.Status_Button0.Enable = 'off';
        UI.Status_Button1.Enable = 'off';
        UI.Status_Button2.Enable = 'off';
        UI.Status_Button3.Enable = 'off';
        UI.Status_Button4.Enable = 'off';
        UI.Status_Button5.Enable = 'off';
        UI.Status_Button6.Enable = 'off';
        UI.Status_Button7.Enable = 'off';
        UI.Status_hold_Button_Text.Enable = 'off';
        UI.Status_hold_Button0.Enable = 'off';
        UI.Status_hold_Button1.Enable = 'off';
        UI.Status_hold_Button2.Enable = 'off';
        UI.Status_hold_Button3.Enable = 'off';
        UI.Status_hold_Button4.Enable = 'off';
        UI.Status_hold_Button5.Enable = 'off';
        UI.Status_hold_Button6.Enable = 'off';
        UI.Status_hold_Button7.Enable = 'off';
    end
    
    % Senden des Wertes zur seriellen Kommunikation (wenn COM-Port offen)
    if (COM_available == 1)
        if (src.Value == 1)
            %Zurücksetzen der Sammelvariablen für die Daten
            Zeit = [];
            x_lin = [];
            x_rot = [];
            v_lin = [];
            v_rot = [];
            a = [];
            a_x = [];
            a_z = [];
            Strom = [];
            Spannung = [];
            Ansteuerung_EM = [];
            % Seriellen-Port aufräumen (im Puffer befindlichen Daten verwerfen)
            flush(board);
            %Senden des Wertes zur seriellen Kommunikation
            tx = [3,1]; % ID für serielle Daten ist 3;
            coded_msg = cobs_TS(tx);
            write(board,coded_msg,'uint8');
            %Command-Window aufräumen
            clc
            %Timer starten
            start(timer_data);
            start(timer_send);
            %UIProperties ändern
            src.BackgroundColor = [0.6 1 0.6];
            src.String = 'Serielle-Daten aus';
        elseif (src.Value == 0)
            %Timer stoppen
            stop(timer_data);
            stop(timer_send);
            %Seriellen-Port aufräumen (im Puffer befindlichen Daten verwerfen)
            flush(board);
            %Senden des Wertes zur seriellen Kommunikation(wenn COM-Port offen)
            tx = [3,0]; % ID für serielle Daten ist 3;
            coded_msg = cobs_TS(tx);
            write(board,coded_msg,'uint8');
            %UIProperties ändern
            src.BackgroundColor = [0.94 0.94 0.94];
            src.String = 'Serielle-Daten ein';
            %x-Achsen zurücksetzen
            Achse.Weg.XLim = [0 10];
            Achse.Geschwindigkeit.XLim = [0 10];
            Achse.Beschleunigung.XLim = [0 10];
            Achse.Strom.XLim = [0 10];
            Achse.Spannung.XLim = [0 10];
            Achse.Ansteuerung.XLim = [0 10];
            %Wenn speichern noch aktiv --> Speichervorgang beenden
            if (UI.Speichern_EinAus.Value == 1)
                UI.Speichern_EinAus.Value = 0;
                UI_Speichern_EinAus(UI.Speichern_EinAus,[],UI)
            end
        end
    else
        disp('Senden nicht möglich. COM-Verbindung nicht geöffnet');
    end
    
    
end