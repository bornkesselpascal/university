function sendData(board,UI,timer,COM_available)
    
    global x_lin Status
    persistent Zeit_Profil
    persistent tx_alt SendOnChange
    
    SendOnChange = 1;   % Wenn 1 wird nur bei Änderung des zu sendenen Signals ein neuer Sendevorgang ausgelöst
    
    if (COM_available == 1)
        % Senden der PWM-Wert Vorgabe
        if (UI.PWM_send.UserData == 1)
            PWM_max = 100;
            PWM_min = -100;

            String = UI.PWM_edit.String;
            String = strrep(String,',','.');
            Wert = str2double(String);

            if isnan(Wert)
                UI.PWM_edit.String = num2str(src.UserData);
                Flag_send = false;
            elseif Wert > PWM_max
                Wert = PWM_max;
                UI.PWM_edit.UserData = PWM_max;
                UI.PWM_edit.String = num2str(PWM_max);
                Flag_send = true;
            elseif Wert < PWM_min
                Wert = PWM_min;
                UI.PWM_edit.UserData = PWM_min;
                UI.PWM_edit.String = num2str(PWM_min);
                Flag_send = true;
            else
                Wert = round(Wert,0);
                UI.PWM_edit.UserData = round(Wert,0);
                UI.PWM_edit.String = num2str(UI.PWM_edit.UserData);
                Flag_send = true;
            end

            Wert = typecast(int16(Wert),'uint8');
            %disp(['Folgender Wert wird gesendet: ' num2str(Wert)]);

            %Senden des Wertes (wenn COM-Port offen)
            if (Flag_send == true)
                tx = [2,Wert(1)]; % ID für PWM-Wert ist 2;
                if ((~isequal(tx,tx_alt)) || (SendOnChange == 0))
                    coded_msg = cobs_TS(tx);
                    %disp(['codierte Message: ' num2str(coded_msg)])
                    write(board,coded_msg,'uint8');
                    tx_alt = tx;
                end
            end
        elseif (UI.PWM_send.UserData == 0)
            tx = [2,0]; % ID für PWM-Wert ist 2;
            if ((~isequal(tx,tx_alt)) || (SendOnChange == 0))
                coded_msg = cobs_TS(tx);
                %disp(['codierte Message: ' num2str(coded_msg)])
                write(board,coded_msg,'uint8');
                tx_alt = tx;
            end
        end
        
        % Fahrprofil wird gestartet
        if (UI.Profilwahl_Start.UserData == 1)
            %Zeitachse berechnen
            if isempty(Zeit_Profil)
                Zeit_Profil = 0;
            else
                Zeit_Profil = Zeit_Profil + timer.Period;
            end
            
            %% Fahrprofile
            if (UI.Profilwahl.UserData == 1)
                %Kennlinie für Sprung 25
                t_End = 30;
                %Festlegen des Profils
                KL_PWM_Soll = [
                    0   3   t_End
                    0   25  0
                    ];
                %Festlegen der Berechnungsmethode
                Variante_interp_KL = 1; % 1 - sprunghafte Änderung der Werte; 2 - lineare Interpolation zwischen den Werten
                if (Variante_interp_KL == 1)
                    PWM_Soll = interp1(KL_PWM_Soll(1,:),KL_PWM_Soll(2,:),Zeit_Profil,'previous',KL_PWM_Soll(2,end));
                elseif (Variante_interp_KL == 2)
                    PWM_Soll = interp1(KL_PWM_Soll(1,:),KL_PWM_Soll(2,:),Zeit_Profil,'linear',KL_PWM_Soll(2,end));
                else
                    PWM_Soll = 0; %EM aus
                end
            elseif (UI.Profilwahl.UserData == 2)
                %Kennlinie für Sprung 30
                t_End = 30;
                %Festlegen des Profils
                KL_PWM_Soll = [
                    0   3   t_End
                    0   30  0
                    ];
                %Festlegen der Berechnungsmethode
                Variante_interp_KL = 1; % 1 - sprunghafte Änderung der Werte; 2 - lineare Interpolation zwischen den Werten
                if (Variante_interp_KL == 1)
                    PWM_Soll = interp1(KL_PWM_Soll(1,:),KL_PWM_Soll(2,:),Zeit_Profil,'previous',KL_PWM_Soll(2,end));
                elseif (Variante_interp_KL == 2)
                    PWM_Soll = interp1(KL_PWM_Soll(1,:),KL_PWM_Soll(2,:),Zeit_Profil,'linear',KL_PWM_Soll(2,end));
                else
                    PWM_Soll = 0; %EM aus
                end
            elseif (UI.Profilwahl.UserData == 3)
                %Kennlinie für Sprung 35
                t_End = 30;
                %Festlegen des Profils
                KL_PWM_Soll = [
                    0   3   t_End
                    0   35  0
                    ];
                %Festlegen der Berechnungsmethode
                Variante_interp_KL = 1; % 1 - sprunghafte Änderung der Werte; 2 - lineare Interpolation zwischen den Werten
                if (Variante_interp_KL == 1)
                    PWM_Soll = interp1(KL_PWM_Soll(1,:),KL_PWM_Soll(2,:),Zeit_Profil,'previous',KL_PWM_Soll(2,end));
                elseif (Variante_interp_KL == 2)
                    PWM_Soll = interp1(KL_PWM_Soll(1,:),KL_PWM_Soll(2,:),Zeit_Profil,'linear',KL_PWM_Soll(2,end));
                else
                    PWM_Soll = 0; %EM aus
                end
            elseif (UI.Profilwahl.UserData == 4)
                %Kennlinie für Sprung 40
                t_End = 30;
                %Festlegen des Profils
                KL_PWM_Soll = [
                    0   3   t_End
                    0   40  0
                    ];
                %Festlegen der Berechnungsmethode
                Variante_interp_KL = 1; % 1 - sprunghafte Änderung der Werte; 2 - lineare Interpolation zwischen den Werten
                if (Variante_interp_KL == 1)
                    PWM_Soll = interp1(KL_PWM_Soll(1,:),KL_PWM_Soll(2,:),Zeit_Profil,'previous',KL_PWM_Soll(2,end));
                elseif (Variante_interp_KL == 2)
                    PWM_Soll = interp1(KL_PWM_Soll(1,:),KL_PWM_Soll(2,:),Zeit_Profil,'linear',KL_PWM_Soll(2,end));
                else
                    PWM_Soll = 0; %EM aus
                end    
            elseif (UI.Profilwahl.UserData == 5)
                %Kennlinie für Profil Sägezahn Teflon
                PWM_Min = 5;
                PWM_Max = 35;
                %Festlegen des Profils
                KL_PWM_Soll = [ 0   3   3.01   3.5       4         4.5        5        5.5       6        6.5        7        7.5        8        8.5       9        9.5        10        10.5        11        11.5       12        12.5        13        13.5        14
                                0   0   25     PWM_Max   PWM_Min   PWM_Max    PWM_Min  PWM_Max   PWM_Min  PWM_Max    PWM_Min  PWM_Max    PWM_Min  PWM_Max   PWM_Min  PWM_Max    PWM_Min   PWM_Max     PWM_Min   PWM_Max    PWM_Min   PWM_Max     PWM_Min   PWM_Max     PWM_Min];
                %Festlegen der Berechnungsmethode
                Variante_interp_KL = 2; % 1 - sprunghafte Änderung der Werte; 2 - lineare Interpolation zwischen den Werten
                if (Variante_interp_KL == 1)
                    PWM_Soll = interp1(KL_PWM_Soll(1,:),KL_PWM_Soll(2,:),Zeit_Profil,'previous',KL_PWM_Soll(2,end));
                elseif (Variante_interp_KL == 2)
                    PWM_Soll = interp1(KL_PWM_Soll(1,:),KL_PWM_Soll(2,:),Zeit_Profil,'linear',KL_PWM_Soll(2,end));
                else
                    PWM_Soll = 0; %EM aus
                end
            elseif (UI.Profilwahl.UserData == 6)
                %Kennlinie für Profil Sägezahn Stahl
                PWM_Min = 7;
                PWM_Max = 40;
                %Festlegen des Profils
                KL_PWM_Soll = [ 0   3   3.01   3.5       4         4.5        5        5.5       6        6.5        7        7.5        8        8.5       9        9.5        10        10.5        11        11.5       12        12.5        13        13.5        14
                                0   0   25     PWM_Max   PWM_Min   PWM_Max    PWM_Min  PWM_Max   PWM_Min  PWM_Max    PWM_Min  PWM_Max    PWM_Min  PWM_Max   PWM_Min  PWM_Max    PWM_Min   PWM_Max     PWM_Min   PWM_Max    PWM_Min   PWM_Max     PWM_Min   PWM_Max     PWM_Min];
                %Festlegen der Berechnungsmethode
                Variante_interp_KL = 2; % 1 - sprunghafte Änderung der Werte; 2 - lineare Interpolation zwischen den Werten
                if (Variante_interp_KL == 1)
                    PWM_Soll = interp1(KL_PWM_Soll(1,:),KL_PWM_Soll(2,:),Zeit_Profil,'previous',KL_PWM_Soll(2,end));
                elseif (Variante_interp_KL == 2)
                    PWM_Soll = interp1(KL_PWM_Soll(1,:),KL_PWM_Soll(2,:),Zeit_Profil,'linear',KL_PWM_Soll(2,end));
                else
                    PWM_Soll = 0; %EM aus
                end    
            end
            clear Variante_interp_KL
            PWM_Soll_uint8 = uint8(PWM_Soll);
            tx = [2,PWM_Soll_uint8]; % ID für PWM-Wert ist 2;
            if ((~isequal(tx,tx_alt)) || (SendOnChange == 0))
                coded_msg = cobs_TS(tx);
                %disp(['codierte Message: ' num2str(coded_msg)])
                write(board,coded_msg,'uint8');
                tx_alt = tx;
            end
            
            if Zeit_Profil >= KL_PWM_Soll(1,end)
                Zeit_Profil = [];
                UI.Profilwahl_Start.UserData = 0;
                UI.Profilwahl_Start.Enable = 'on';
                UI.Profilwahl_Stop.Enable = 'off';
                UI.PWM_edit.Enable = 'on';
                UI.PWM_send.Enable = 'on';
            end
        % Beenden des Fahrprofils
        elseif (UI.Profilwahl_Start.UserData == 0)
            if ~isempty(Zeit_Profil)
                Zeit_Profil = [];
            end
            tx = [2,0]; % ID für PWM-Wert ist 2;
            if ((~isequal(tx,tx_alt)) || (SendOnChange == 0))
                coded_msg = cobs_TS(tx);
                %disp(['codierte Message: ' num2str(coded_msg)])
                write(board,coded_msg,'uint8');
                tx_alt = tx;
            end
        end
    % Wenn keine COM-Verbindung besteht    
    elseif (COM_available == 0)
        disp('Senden nicht möglich. COM-Verbindung nicht geöffnet');
    else
        disp('Fehler');
    end 
end