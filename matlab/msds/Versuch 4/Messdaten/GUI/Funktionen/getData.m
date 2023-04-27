function getData(board,Achse,Linie,UI,timer)

    global Zeit x_lin x_rot v_lin v_rot a a_x a_z Strom Spannung Ansteuerung_EM Status
    global Zeit_save x_lin_save x_rot_save v_lin_save v_rot_save a_save a_x_save a_z_save Strom_save Spannung_save Ansteuerung_EM_save Status_save
    global Error_Counter Disp_Errors Success_Counter Position_Ref Flag_Synchro Offset_Synchro_xlin Offset_Synchro_xrot
    persistent payload x_lin_rem Zeit_rem    
    %% allgemein benötigte Variablen festlegen
    INC = 2048;                     % Inkremente des Encoders
    r_Zahnrad = 25;                 % wirksamer Radius des Antriebszahnrads in [mm]
    Korr_Faktor_x_lin = 0.844409664;  % Korrekturfaktor für Berechnung x_rot (wirksamer Radius des Zahnrads = r_Zahnrad * Korr_Faktor_x_lin
    
    %% Variablendefinitionen (temporäre Variablen)
    Zeit_temp = [];
    x_lin_temp = [];
    x_rot_temp = [];
    v_lin_temp = [];
    v_rot_temp = [];
    a_temp = [];
    a_x_temp = [];
    a_z_temp = [];
    Strom_temp = [];
    Spannung_temp = [];
    Ansteuerung_EM_temp = [];
    Status_temp = [];
    
    Inkremente_temp = [];
    
    %Dekodiervariante festlegen
    Decode_Variante = 2;
    Frame_Laenge = 21;      % Anzahl der Bytes die je Paket vom ESP32 kommen
    Frame_Laenge_COBS = Frame_Laenge + 2; 
    
    %% Einlesen der Daten vom seriellen Bus  
    if board.NumBytesAvailable >= 10*Frame_Laenge_COBS
        %alle Daten aus Puffer einlesen
        payload = cat(2,payload,read(board,board.NumBytesAvailable,'uint8'));
        %suchen der Trennzeichen für Datenpakete (Wert 0, durch COBS wird ein senden anderer 0-Werte verhindert)
        Indizes = find(payload==0);
        %extrahieren der Daten aus dem Datenstrom
        if ~isempty(Indizes)
            for i=1:length(Indizes)
                if i == 1
                    coded_msg_alt = [];
                    coded_msg = payload(1:Indizes(i))';
                else
                    coded_msg_alt = coded_msg;
                    coded_msg = payload(Indizes(i-1)+1:Indizes(i))';
                end

                %Unterscheidung der unterschiedlichen Datenpakete und extrahieren der entsprechenden Werte
                %-----------------------------------------------------------------------------------------
                if (length(coded_msg) ~= Frame_Laenge_COBS)
                    Error_Counter = Error_Counter+1;
                    if (Disp_Errors == 1)
                        disp(['--------Anzahl Bytes nicht plausibel ( ' num2str(length(coded_msg)) ' Bytes ) --------------------------------'])
                        disp(['alter codierter Datensatz:   ' num2str(coded_msg_alt)])
                        disp(['neuer codierter Datensatz:   ' num2str(coded_msg)])
                        if Decode_Variante == 1
                            coded_msg(end) = [];    %letzte Null (Trennzeichen) entfernen, sonst funktioniert cobsi-Funktion nicht
                            decoded_msg = cobsi_TS(coded_msg); %dekodieren der COBS-Daten
                        else
                            decoded_msg = cobsi_TS_2(coded_msg);
                        end
                        
                        disp(['neuer decodierter Datensatz: ' num2str(decoded_msg)])
                        disp(['Index:               ' num2str(i)])
                        clear decoded_msg
                    end
                %reguläres Paket (hat mit COBS-Overhead 2 Byte mehr als reine Daten-Bytes)
                elseif (length(coded_msg) == Frame_Laenge_COBS)
                    %disp(['codierte Daten: ' num2str(coded_msg)])
                    if Decode_Variante == 1
                        coded_msg(end) = [];    %letzte Null (Trennzeichen) entfernen, sonst funktioniert cobsi-Funktion nicht
                        decoded_msg = cobsi_TS(coded_msg); %dekodieren der COBS-Daten
                    else
                        decoded_msg = cobsi_TS_2(coded_msg);
                    end
                    %disp(['decodierte Daten: ' num2str(decoded_msg)])

                    %Werte berechnen
                    if (length(decoded_msg) == Frame_Laenge)
                      decoded_msg = uint8(decoded_msg);  
                      Zeit_temp = cat(1,Zeit_temp,double(typecast(decoded_msg(1:4),'uint32')));
                      x_lin_temp = cat(1,x_lin_temp,double(typecast(decoded_msg(5:6),'int16')));
                      Inkremente_temp = cat(1,Inkremente_temp,double(typecast(decoded_msg(7:10),'int32')));
                      Strom_temp = cat(1,Strom_temp,double(typecast(decoded_msg(11:12),'int16')));
                      Spannung_temp = cat(1,Spannung_temp,double(typecast(decoded_msg(13:14),'int16')));
                      a_x_temp = cat(1,a_x_temp,double(typecast(decoded_msg(15:16),'int16')));
                      a_z_temp = cat(1,a_z_temp,double(typecast(decoded_msg(17:18),'int16')));
                      Ansteuerung_EM_temp = cat(1,Ansteuerung_EM_temp,double(typecast(decoded_msg(19:20),'int16')));
                      Status_temp = cat(1,Status_temp,double(typecast(decoded_msg(21),'uint8')));
                      Success_Counter = Success_Counter+1;
                    else
                        Error_Counter = Error_Counter+1;
                        if (Disp_Errors == 1)
                            disp('Hier läuft was falsch !')
                            disp(['alter codierter Datensatz:   ' num2str(coded_msg_alt)])
                            disp(['neuer codierter Datensatz:   ' num2str(coded_msg)])
                            disp(['neuer decodierter Datensatz: ' num2str(decoded_msg)])
                            disp(['Index:                 ' num2str(i)])
                        end
                    end
                    clear decoded_msg
                end
            end
            % Daten die ausgelesen wurden löschen (Rest der Daten verbleibt im Array!!!)
            payload(1:Indizes(end)) = [];
        end
        %Ausgabe der nun im Puffer befindlichen Daten (nur zu Info-Zwecken)
        %disp(['Bytes im Puffer: ' num2str(board.BytesAvailable)])
    
        %% Daten-Arrays zusammenbauen
        %Zeitwerte 
        if ~isempty(Zeit_temp)
            % Zeitwerte in s umrechnen
            %Zeit_temp = Zeit_temp/1e3;  %bei ms
            Zeit_temp = Zeit_temp/1e6;  %bei us
        end

        %x_lin-Werte;
        if ~isempty(x_lin_temp)
            %Hier kann Umrechnung der Werte eingefügt werden
            % zu Hause
            %x_interp = [123.3  224.4  385.6  538.1  663.3  824.9  947.0  1062.3  1169.6  1281.4  1380.4  1484.5  1602.6]; 
            %y_interp = [120    200    300    400    500    600    700    800     900     1000    1100    1200    1315];
            
            % Labor
            x_interp = [97     198     297     394     484     570     663     748     842     925     1015    1090    1175    1250.8];
            y_interp = [100    200     300     400     500     600     700     800     900     1000    1100    1200    1298    1351];
            
            % zu Kalibrierung
            %x_interp = [0   1600];
            %y_interp = [0   1600];
            
            x_lin_temp = interp1(x_interp,y_interp,x_lin_temp,'linear','extrap');
            
            x_lin_temp = x_lin_temp - Offset_Synchro_xlin;
            
            %Berechnung der Geschwindigkeit v_lin (aktuell nur Dummy)
            Dummy_Act = 0;
            if (Dummy_Act == 1)
                if isempty(x_lin)
                   v_lin_temp = diff(x_lin_temp)./diff(Zeit_temp);
                   v_lin_temp = cat(1,0,v_lin_temp)/1000;
                else
                   Temp_x = cat(1,x_lin(end),x_lin_temp);
                   Temp_t = cat(1,Zeit(end),Zeit_temp);
                   v_lin_temp = diff(Temp_x)./diff(Temp_t)/1000;
                   clear Temp_x Temp_t
                end
            else
                if isempty(x_lin)
                   dx_lin_temp = diff(cat(1,x_lin_temp(1),x_lin_temp));
                   Indizes = find(dx_lin_temp~=0);
                   if (~isempty(Indizes))
                       if (length(Indizes) >= 3)
                            Zeit_v_lin = Zeit_temp(Indizes);
                            Zeit_rem = Zeit_temp(Indizes(end));
                            x_lin_v_lin = x_lin_temp(Indizes);
                            x_lin_rem = x_lin_temp(Indizes(end));
                            v_lin_temp = diff(x_lin_v_lin)./diff(Zeit_v_lin);
                            v_lin_temp = interp1(Zeit_v_lin,cat(1,0,v_lin_temp),Zeit_temp,'linear','extrap');
                       elseif (length(Indizes) == 2)
                           Zeit_v_lin = Zeit_temp(Indizes);
                           Zeit_rem = Zeit_temp(Indizes(end));
                           x_lin_v_lin = x_lin_temp(Indizes);
                           x_lin_rem = x_lin_temp(Indizes(end));
                           v_lin_temp = diff(x_lin_v_lin)./diff(Zeit_v_lin);
                           v_lin_temp = ones(length(Zeit_temp),1)*v_lin_temp;
                       else
                           Zeit_rem = Zeit_temp(end);
                           x_lin_rem = x_lin_temp(end);
                           v_lin_temp = zeros(length(Zeit_temp),1);
                       end
                   else
                       Zeit_rem = Zeit_temp(end);
                       x_lin_rem = x_lin_temp(end);
                       v_lin_temp = zeros(length(Zeit_temp),1);
                   end
                   v_lin_temp = v_lin_temp/1000;              
                else
                   x_lin_Hilfe =  cat(1,x_lin_rem,x_lin_temp);
                   Zeit_Hilfe = cat(1,Zeit_rem,Zeit_temp);
                   dx_lin_temp = diff(x_lin_Hilfe);  
                   Indizes = find(dx_lin_temp~=0);
                   if (~isempty(Indizes))
                       if (length(Indizes) >= 3)
                            Zeit_v_lin = Zeit_Hilfe(Indizes);
                            Zeit_rem = Zeit_Hilfe(Indizes(end));
                            x_lin_v_lin = x_lin_Hilfe(Indizes);
                            x_lin_rem = x_lin_Hilfe(Indizes(end));
                            v_lin_temp = diff(x_lin_v_lin)./diff(Zeit_v_lin);
                            v_lin_temp = interp1(Zeit_v_lin(2:end),v_lin_temp,Zeit_temp,'linear','extrap');
                       elseif (length(Indizes) == 2)
                           Zeit_v_lin = Zeit_Hilfe(Indizes);
                            Zeit_rem = Zeit_Hilfe(Indizes(end));
                            x_lin_v_lin = x_lin_Hilfe(Indizes);
                            x_lin_rem = x_lin_Hilfe(Indizes(end));
                            v_lin_temp = diff(x_lin_v_lin)./diff(Zeit_v_lin);
                            v_lin_temp = ones(length(Zeit_temp),1)*v_lin_temp;
                       else
                           Zeit_rem = Zeit_temp(end);
                           x_lin_rem = x_lin_temp(end);
                           v_lin_temp = zeros(length(Zeit_temp),1);
                       end
                   else
                       Zeit_rem = Zeit_temp(end);
                       x_lin_rem = x_lin_temp(end);
                       v_lin_temp = zeros(length(Zeit_temp),1);
                   end
                   v_lin_temp = v_lin_temp/1000;                         
                end
                clear dx_lin_temp Indizes Zeit_v_lin x_lin_v_lin Zeit_Hilfe x_lin_Hilfe
            end
        end

        %x_rot-Werte;
        if ~isempty(Inkremente_temp)
            %Berechnung der Verschiebung aus Encoder-Werten
            x_rot_temp = -(Inkremente_temp/INC)*2*pi*r_Zahnrad*Korr_Faktor_x_lin - Offset_Synchro_xrot;
            %Berechnung der Geschwindigkeit v_rot (aktuell nur Dummy)
            if (Dummy_Act == 1)
                v_rot_temp = x_rot_temp;
            else
                if isempty(x_rot)
                   v_rot_temp = diff(x_rot_temp)./diff(Zeit_temp);
                   v_rot_temp = cat(1,0,v_rot_temp)/1000;
                else
                   Temp_x = cat(1,x_rot(end),x_rot_temp);
                   Temp_t = cat(1,Zeit(end),Zeit_temp);
                   v_rot_temp = diff(Temp_x)./diff(Temp_t)/1000;
                   clear Temp_x Temp_t
                end
            end
        end
        
        %a-Werte;
        if ~isempty(a_x_temp)
            %Hier kann Umrechnung der Werte eingefügt werden
            a_x_temp = a_x_temp/1000; % Umrechnung in m/s^2
            a_z_temp = a_z_temp/1000; % Umrechnung in m/s^2
            
            %prüfen ob Vektoren der Beschleunigungen in x- und z-Richtung gleiche Länge aufweisen
            if (length(a_x_temp) == length(a_z_temp))
                a_temp = sqrt(a_x_temp.^2+a_z_temp.^2).*sign(a_x_temp);
            end
        end
        
        %Strom-Werte;
        if ~isempty(Strom_temp)
            %Hier kann Umrechnung der Werte eingefügt werden
            Strom_temp = Strom_temp/1e3;
        end
        
        %Spannungs-Werte;
        if ~isempty(Spannung_temp)
            %Hier kann Umrechnung der Werte eingefügt werden
            Spannung_temp = Spannung_temp/1e3;
        end
        
        %Ansteuerung_EM-Werte;
        if ~isempty(Ansteuerung_EM_temp)
            %Hier kann Umrechnung der Werte eingefügt werden
            Ansteuerung_EM_temp = Ansteuerung_EM_temp/4;
        end
        
        %Status 
        if ~isempty(Status_temp)
            % Wenn Status auf Notabaschaltung hinweist 
            % --> "stoppen"-Button auf "ausgeben" ändern
            % --> Fahrprofilwahl auf Start setzen
            %if (bitand(max(Status_temp),15) > 0)
            if (max(bitand(Status_temp,15) > 0))
                UI.PWM_send.String = "ausgeben";
                UI.PWM_send.Value = 0;
                UI.PWM_send.UserData = 0;
                UI.PWM_send.Enable = 'on';
                UI.PWM_edit.Enable = 'on';
                
                UI.Profilwahl_Start.Enable = 'on';
                UI.Profilwahl.Enable = 'on';
                UI.Profilwahl_Stop.Enable = 'off';
                UI.Profilwahl_Start.UserData = 0;
                
            end
        end
        
        

        %% Prüfung auf Zeitachsenfehlern und ggf. korrigieren
        ZeitachsenKorr_Act = 0;
        if (ZeitachsenKorr_Act == 1);
            dt_min = min(abs(diff(Zeit_temp)));
            dt_max = max(abs(diff(Zeit_temp)));
            if (~isempty(dt_max) && dt_max > 3*dt_min)
                Flag_CorrTime = 1;
            else
                Flag_CorrTime = 0;
            end
            clear dt_min dt_max
            if (~(issorted(Zeit_temp)) || Flag_CorrTime == 1)
                %umsortieren der Zeitachse
                [Zeit_temp,idx] = corrTime(Zeit_temp,'SCHNELL',1);
                %entsprechende Daten gleichermaßen umsortieren
                x_lin_temp = x_lin_temp(idx);
                x_rot_temp = x_rot_temp(idx);
                v_lin_temp = v_lin_temp(idx);
                v_rot_temp = v_rot_temp(idx);
                a_x_temp = a_x_temp(idx);
                a_z_temp = a_z_temp(idx);
                a_temp = a_temp(idx);
                Strom_temp = Strom_temp(idx);
                Spannung_temp = Spannung_temp(idx);
                Ansteuerung_EM_temp = Ansteuerung_EM_temp(idx);
                Status_temp = Status_temp(idx);
                clear idx
            end   
            clear Flag_CorrTime
        end
        

        %% eingelesene Daten an Arrays anhängen
        Zeit = cat(1,Zeit,Zeit_temp);
        x_lin = cat(1,x_lin,x_lin_temp);
        x_rot = cat(1,x_rot,x_rot_temp);
        v_lin = cat(1,v_lin,v_lin_temp);
        v_rot = cat(1,v_rot,v_rot_temp);
        a_x = cat(1,a_x,a_x_temp);
        a_z = cat(1,a_z,a_z_temp);
        a = cat(1,a,a_temp);
        Strom = cat(1,Strom,Strom_temp);
        Spannung = cat(1,Spannung,Spannung_temp);
        Ansteuerung_EM = cat(1,Ansteuerung_EM,Ansteuerung_EM_temp);
        Status = cat(1,Status,Status_temp);
        

        %% zu speichernde Daten ablegen 
        %(nur wenn Speicherbutton aktiviert)
        if UI.Speichern_EinAus.Value == 1
            Zeit_save = cat(1,Zeit_save,Zeit_temp);
            x_lin_save = cat(1,x_lin_save,x_lin_temp);
            x_rot_save = cat(1,x_rot_save,x_rot_temp);
            v_lin_save = cat(1,v_lin_save,v_lin_temp);
            v_rot_save = cat(1,v_rot_save,v_rot_temp);
            a_x_save = cat(1,a_x_save,a_x_temp);
            a_z_save = cat(1,a_z_save,a_z_temp);
            a_save = cat(1,a_save,a_temp);
            Strom_save = cat(1,Strom_save,Strom_temp);
            Spannung_save = cat(1,Spannung_save,Spannung_temp);
            Ansteuerung_EM_save = cat(1,Ansteuerung_EM_save,Ansteuerung_EM_temp);
            Status_save = cat(1,Status_save,Status_temp);
        end

        %% Daten zuschneiden
        Zuschneiden_Act = 1;
        if Zuschneiden_Act == 1
            % nur die zu plottenden Daten im Speicher behalten, um die Berechnung
            % schnell zu halten

            Offset = 0; % legt fest, wieviele Daten vor dem eigentlichen Start_index noch behalten werden sollen

            %Auslesen welches Zeitintervall geplottet werden soll
            %String = UI.Zeitachse_edit.String;
            %String = strrep(String,',','.');
            %dt = str2double(String);
            %clear String
            dt = 10;
            
            %Zuschneiden der schnellen Daten
            Zeit_Temp_index = [];
            if ~isempty(Zeit)
                Zeit_start = Zeit(end)-dt;
                Start_index = find(Zeit>=Zeit_start,1);              
                %Wegwerfen der überflüssigen Daten
                if ((Start_index-Offset) > 0)
                    Zeit(1:Start_index-Offset-2) = [];
                    x_lin(1:Start_index-Offset-2) = [];
                    x_rot(1:Start_index-Offset-2) = [];
                    v_lin(1:Start_index-Offset-2) = [];
                    v_rot(1:Start_index-Offset-2) = [];
                    a_x(1:Start_index-Offset-2) = [];
                    a_z(1:Start_index-Offset-2) = [];
                    a(1:Start_index-Offset-2) = [];
                    Strom(1:Start_index-Offset-2) = [];
                    Spannung(1:Start_index-Offset-2) = [];
                    Ansteuerung_EM(1:Start_index-Offset-2) = [];
                    Status(1:Start_index-Offset-2) = [];
                end
                clear Start_index
            end
            clear dt Offset Zeit_start
        end        
    end
    %% Prüfung der Synchronisation
    if (~isempty(x_lin_temp) && (Flag_Synchro == true))
        Schwelle_x_diff = 30;
        MaxChange_x_rot = 3;
        Change_x_rot = max(x_rot_temp) - min(x_rot_temp);
        x_diff = x_rot_temp - x_lin_temp;
        if ((abs(mean(x_diff)) >= Schwelle_x_diff) && (abs(Change_x_rot) < MaxChange_x_rot))
            UI.Synchro_new.BackgroundColor = [1 0 0];
        end
        clear Schwelle_x_diff x_diff
    end
    
    
    %% Synchronisation der Wegmessungen vornehmen
    if (length(x_lin > 3) && ~isempty(x_lin_temp))
        Temp_Synchrowert = str2double(UI.Synchro_edit.String)+str2double(UI.Nullpunkt_edit.String);
        Temp_Synchroflag = diff(sign(x_lin - Temp_Synchrowert));
        Index_Synchroflag = find(Temp_Synchroflag <= -1,1);
        if (~isempty(Index_Synchroflag) && (Flag_Synchro == false) && (max(x_lin_temp <= Temp_Synchrowert)))
            Flag_Synchro = true;
            Offset_Synchro_xlin = x_lin(Index_Synchroflag)-str2double(UI.Synchro_edit.String);
            Offset_Synchro_xrot = x_rot(Index_Synchroflag)-str2double(UI.Synchro_edit.String);
            UI.Synchro_edit.BackgroundColor = [0.6 1 0.6];
            UI.Synchro_new.Visible = 'on';
        end
        clear Temp_Synchrowert Temp_Synchroflag Index_Synchroflag
    end
            
    
    %% Daten plotten
    PlotAct = 1;
    if (PlotAct == 1)
        if (rem(timer.TasksExecuted,2)==0)
            plotData(Achse,Linie,UI)
        end
    end
    
    %% Zusatzinfos
    %Ausgabe der Periodendauer
    if (rem(timer.TasksExecuted,10)==0)
            %disp(['Die mittlere Ausführungsrate beträgt: ' num2str(timer.AveragePeriod)]);
    end
        
    %Möglichkeit zur Unterbrechung
    if (size(Zeit,1) > 2000)
        %disp('zum Unterbrechen des Daten-Einlesens')
    end
end