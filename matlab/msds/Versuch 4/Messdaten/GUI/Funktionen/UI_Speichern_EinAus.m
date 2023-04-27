function UI_Speichern_EinAus(src,evt,Default_Savepath,UI)

    global Zeit_save x_lin_save x_rot_save v_lin_save v_rot_save a_save a_x_save a_z_save Strom_save Spannung_save Ansteuerung_EM_save Status_save
    
    % Auslesen des Eingabewertes aus Toggle-Button
    Wert = UI.Speichern_EinAus.Value;
    
    if (src.Value == 1)
        disp('Speichern beginnt')
        %Farbe und Beschriftung des Toggle-Buttons ändern
        src.BackgroundColor = [1 0 0];
        src.String = 'Aufzeichnung stoppen';
    elseif (src.Value == 0) %fallende Flanke
        disp('Speichern beendet')
        
        FileName = 'Daten_V5_';
        
        %Filenamen automatisch inkrementieren
        Ink_Filename = 1;
        if (Ink_Filename == 1)
            Files = dir(Default_Savepath);
            Max_Messnummer = 0;
            for i = 1:length(Files)
                Filename = Files(i).name;
                if (~isempty(strfind(Files(i).name,FileName)))
                    Temp_Messnummer = strrep(Files(i).name,FileName,'');
                    Temp_Messnummer = str2double(strrep(Temp_Messnummer,'.mat',''));
                    if (Temp_Messnummer > Max_Messnummer) Max_Messnummer = Temp_Messnummer; end
                end
            end
            Default_Filename = fullfile(Default_Savepath,[FileName num2str(Max_Messnummer+1) '.mat']);
        else
            Default_Filename = fullfile(Default_Savepath,[FileName(1:end-1) '.mat']);
        end
        
        [file,path] = uiputfile('.mat','Messdaten speichern...',Default_Filename);
        
        clear ActPath Ink_Filename Files Max_Messnummer i Filename Temp_Messnummer Default_Filename FileName
        
        if ~isnumeric(file)
            %Daten vor dem Speichern aufbereiten
            %-----------------------------------
            %Zeit
            Zeit_save_temp = Zeit_save;
            if ~isempty(Zeit_save)
                %hier können noch Anpassungen vor dem Speichern vorgenommen werden
                Zeit_save_temp = Zeit_save_temp - Zeit_save_temp(1); % Anfangszeitwert auf 0 setzen
            end
            
            %x_lin
            x_lin_save_temp = x_lin_save;
            if ~isempty(x_lin_save)     
                 %hier können noch Anpassungen vor dem Speichern vorgenommen werden
            end
            
            %x_rot
            x_rot_save_temp = x_rot_save;
            if ~isempty(x_rot_save)     
                 %hier können noch Anpassungen vor dem Speichern vorgenommen werden
            end
            
            %v_lin
            Flag_Neuberechnung = 1;
            if (Flag_Neuberechnung == 1);
                dx_lin_temp= diff(x_lin_save_temp);
                Indizes = find(dx_lin_temp~=0);
                if (~isempty(Indizes))
                    if (length(Indizes) >= 3)
                        Zeit_v_lin = Zeit_save_temp(Indizes);
                        x_lin_v_lin = x_lin_save_temp(Indizes);
                        v_lin_temp = diff(x_lin_v_lin)./diff(Zeit_v_lin);
                        v_lin_temp = interp1(Zeit_v_lin(2:end),v_lin_temp,Zeit_save_temp,'linear','extrap');
                        v_lin_temp = v_lin_temp/1000;
                        v_lin_save_temp = movmean(v_lin_temp,3);
                    end
                else 
                    v_lin_save_temp = v_lin_save;
                end
            else
                v_lin_save_temp = v_lin_save;
            end
            
            if ~isempty(v_lin_save)     
                 %hier können noch Anpassungen vor dem Speichern vorgenommen werden
            end
            
            %v_rot
            v_rot_save_temp = v_rot_save;
            if ~isempty(v_rot_save)     
                 %hier können noch Anpassungen vor dem Speichern vorgenommen werden
            end
            
            %a
            a_save_temp = a_save;
            if ~isempty(a_save)     
                 %hier können noch Anpassungen vor dem Speichern vorgenommen werden
            end
            
            %a_x
            a_x_save_temp = a_x_save;
            if ~isempty(a_x_save)     
                 %hier können noch Anpassungen vor dem Speichern vorgenommen werden
            end
            
            %a_z
            a_z_save_temp = a_z_save;
            if ~isempty(a_z_save)     
                 %hier können noch Anpassungen vor dem Speichern vorgenommen werden
            end
            
            %Strom
            Strom_save_temp = Strom_save;
            if ~isempty(Strom_save)     
                 %hier können noch Anpassungen vor dem Speichern vorgenommen werden
            end
            
            %Spannung
            Spannung_save_temp = Spannung_save;
            if ~isempty(Spannung_save)     
                 %hier können noch Anpassungen vor dem Speichern vorgenommen werden
            end
            
            %Ansteuerung_EM
            Ansteuerung_EM_save_temp = Ansteuerung_EM_save;
            if ~isempty(Ansteuerung_EM_save)     
                 %hier können noch Anpassungen vor dem Speichern vorgenommen werden
            end
            
            %Status
            Status_save_temp = Status_save;
            if ~isempty(Status_save)     
                 %hier können noch Anpassungen vor dem Speichern vorgenommen werden
            end
            
            
            %Variablennamen festlegen
            Zeit = Zeit_save_temp;
            x_lin = x_lin_save_temp;
            x_rot = x_rot_save_temp;
            v_lin = v_lin_save_temp;
            v_rot = v_rot_save_temp;
            a = a_save_temp;
            a_x = a_x_save_temp;
            a_z = a_z_save_temp;
            i_A = Strom_save_temp;
            U_B = Spannung_save_temp;
            PWM_EM = Ansteuerung_EM_save_temp;
            Status = Status_save_temp;
            
            %speichern der Daten
            save(fullfile(path,file),'Zeit','x_lin','x_rot','v_lin','v_rot','a','a_x','a_z','i_A','U_B','PWM_EM','Status')
            
            clear file path ...
                  Zeit_save_temp x_lin_save_temp x_rot_save_temp v_lin_save_temp v_rot_save_temp a_save_temp a_x_save_temp a_z_save_temp...
                  Strom_save_temp Spannung_save_temp Ansteuerung_EM_save_temp Status_save_temp...
                  Zeit x_lin x_rot v_lin v_rot a a_x a_z i_A U_B PWM_EM Status
        end
        %Farbe und Beschriftung des Toggle-Buttons ändern
        src.BackgroundColor = [0.94 0.94 0.94];
        src.String = 'Daten speichern';
        %Variablen zum Speichern der Werte leeren
        Zeit_save = [];
        x_lin_save = [];
        x_rot_save = [];
        v_lin_save = [];
        v_rot_save = [];
        a_save = [];
        a_x_save = [];
        a_z_save = [];
        Strom_save = [];
        Spannung_save = [];
        Ansteuerung_EM_save = [];
        Status_save = [];
    end
end