function plotData(Achse,Linie,UI)

    global Zeit x_lin x_rot v_lin v_rot a a_x a_z Strom Spannung Ansteuerung_EM Status
    
    if ~isempty(Zeit) 
        Stop_index = length(Zeit);
    end
    
    % Weg
    if ~isempty(x_lin)
        %Daten aus Linien löschen
        clearpoints(Linie.Weg_lin);
        clearpoints(Linie.Weg_rot);
        %neue Daten zufügen
        addpoints(Linie.Weg_lin,Zeit,x_lin);
        addpoints(Linie.Weg_rot,Zeit,x_rot);
        if ((Stop_index > 1) && Zeit(Stop_index) > Achse.Weg.XLim(2))
            Achse.Weg.XLim = [Zeit(1) Zeit(Stop_index)];
        end
    end
    
    % Geschwindigkeit
    if ~isempty(v_lin)
        %Daten aus Linien löschen
        clearpoints(Linie.Geschwindigkeit_lin);
        clearpoints(Linie.Geschwindigkeit_rot);
        %neue Daten zufügen
        addpoints(Linie.Geschwindigkeit_lin,Zeit,v_lin);
        addpoints(Linie.Geschwindigkeit_rot,Zeit,v_rot);
        if ((Stop_index > 1) && Zeit(Stop_index) > Achse.Geschwindigkeit.XLim(2))
            Achse.Geschwindigkeit.XLim = [Zeit(1) Zeit(Stop_index)];
        end
    end
    
    % Beschleunigung
    if ~isempty(a)
        %Daten aus Linien löschen
        clearpoints(Linie.Beschleunigung);
        clearpoints(Linie.Beschleunigung_x);
        clearpoints(Linie.Beschleunigung_z);
        %neue Daten zufügen
        addpoints(Linie.Beschleunigung,Zeit,a);
        addpoints(Linie.Beschleunigung_x,Zeit,a_x);
        addpoints(Linie.Beschleunigung_z,Zeit,a_z);
        if ((Stop_index > 1) && Zeit(Stop_index) > Achse.Beschleunigung.XLim(2))
            Achse.Beschleunigung.XLim = [Zeit(1) Zeit(Stop_index)];
        end
    end
    
    % Strom
    if ~isempty(Strom)
        %Daten aus Linien löschen
        clearpoints(Linie.Strom);
        %neue Daten zufügen
        addpoints(Linie.Strom,Zeit,Strom);
        if ((Stop_index > 1) && Zeit(Stop_index) > Achse.Strom.XLim(2))
            Achse.Strom.XLim = [Zeit(1) Zeit(Stop_index)];
        end
        %Achsenskalierung bei Bedarf anpassen
        if (max(Strom) > Achse.Strom.YLim(2))
            Achse.Strom.YLim = [Achse.Strom.YLim(1) 1.1*max(Strom)];
        elseif (max(Strom) <= 3)
            Achse.Strom.YLim = [Achse.Strom.YLim(1) 1.5];
        end
    end
    
    % Spannung
    if ~isempty(Spannung)
        %Daten aus Linien löschen
        clearpoints(Linie.Spannung);
        %neue Daten zufügen
        addpoints(Linie.Spannung,Zeit,Spannung);
        if ((Stop_index > 1) && Zeit(Stop_index) > Achse.Spannung.XLim(2))
            Achse.Spannung.XLim = [Zeit(1) Zeit(Stop_index)];
        end
    end
    
    % Ansteuerung_EM
    if ~isempty(Spannung)
        %Daten aus Linien löschen
        clearpoints(Linie.Ansteuerung);
        %neue Daten zufügen
        addpoints(Linie.Ansteuerung,Zeit,Ansteuerung_EM);
        if ((Stop_index > 1) && Zeit(Stop_index) > Achse.Ansteuerung.XLim(2))
            Achse.Ansteuerung.XLim = [Zeit(1) Zeit(Stop_index)];
        end
    end
    
    drawnow;
    
    %letzter Messwert des Abstands im Edit-Fenster
    if ~isempty(x_lin)
        Variante_xlin = 2;
        if Variante_xlin == 1
            UI.xlin_edit.String = num2str(x_lin(end),'%4.0f');
            UI.xdiff_edit.String = num2str(x_lin(end)-x_rot(end),'%4.0f');
        else
            x_lin_Temp = movmean(x_lin,30);
            UI.xlin_edit.String = num2str(x_lin_Temp(end),'%4.0f');
            UI.xdiff_edit.String = num2str(x_lin_Temp(end)-x_rot(end),'%4.0f');
            clear x_lin_Temp
        end
        clear Variante_xlin
    end
    
    %Status
    if ~isempty(Status)
        %UI ändern
        Wert = Status(end);
        UI.Status_edit.String = num2str(Wert);
        
        %Bit0 setzen
        Comp_Wert = 1;
        if (bitand(Wert, Comp_Wert) == Comp_Wert)
            UI.Status_Button0.Value = 1;
        else
            UI.Status_Button0.Value = 0;
        end
        %Bit1 setzen
        Comp_Wert = 2;
        if (bitand(Wert, Comp_Wert) == Comp_Wert)
            UI.Status_Button1.Value = 1;
        else
            UI.Status_Button1.Value = 0;
        end
        %Bit2 setzen
        Comp_Wert = 4;
        if (bitand(Wert, Comp_Wert) == Comp_Wert)
            UI.Status_Button2.Value = 1;
        else
            UI.Status_Button2.Value = 0;
        end
        %Bit3 setzen
        Comp_Wert = 8;
        if (bitand(Wert, Comp_Wert) == Comp_Wert)
            UI.Status_Button3.Value = 1;
        else
            UI.Status_Button3.Value = 0;
        end
        %Bit4 setzen
        Comp_Wert = 16;
        if (bitand(Wert, Comp_Wert) == Comp_Wert)
            UI.Status_Button4.Value = 1;
        else
            UI.Status_Button4.Value = 0;
        end
        %Bi5 setzen
        Comp_Wert = 32;
        if (bitand(Wert, Comp_Wert) == Comp_Wert)
            UI.Status_Button5.Value = 1;
        else
            UI.Status_Button5.Value = 0;
        end
        %Bit6 setzen
        Comp_Wert = 64;
        if (bitand(Wert, Comp_Wert) == Comp_Wert)
            UI.Status_Button6.Value = 1;
        else
            UI.Status_Button6.Value = 0;
        end
        %Bit7 setzen
        Comp_Wert = 128;
        if (bitand(Wert, Comp_Wert) == Comp_Wert)
            UI.Status_Button7.Value = 1;
        else
            UI.Status_Button7.Value = 0;
        end      
    end
    
    %Status_hold
    if ~isempty(Status)
        Index_Start = UI.Status_hold_Button_Text.UserData;
        
        %Bit0 setzen
        Comp_Wert = 1;
        if (max(bitand(Status(Index_Start:end), Comp_Wert)) == Comp_Wert)
            UI.Status_hold_Button0.Value = 1;
        end
        %Bit1 setzen
        Comp_Wert = 2;
        if (max(bitand(Status(Index_Start:end), Comp_Wert)) == Comp_Wert)
            UI.Status_hold_Button1.Value = 1;
        end
        %Bit2 setzen
        Comp_Wert = 4;
        if (max(bitand(Status(Index_Start:end), Comp_Wert)) == Comp_Wert)
            UI.Status_hold_Button2.Value = 1;
        end
        %Bit3 setzen
        Comp_Wert = 8;
        if (max(bitand(Status(Index_Start:end), Comp_Wert)) == Comp_Wert)
            UI.Status_hold_Button3.Value = 1;
        end
        %Bit4 setzen
        Comp_Wert = 16;
        if (max(bitand(Status(Index_Start:end), Comp_Wert)) == Comp_Wert)
            UI.Status_hold_Button4.Value = 1;
        end
        %Bi5 setzen
        Comp_Wert = 32;
        if (max(bitand(Status(Index_Start:end), Comp_Wert)) == Comp_Wert)
            UI.Status_hold_Button5.Value = 1;
        end
        %Bit6 setzen
        Comp_Wert = 64;
        if (max(bitand(Status(Index_Start:end), Comp_Wert)) == Comp_Wert)
            UI.Status_hold_Button6.Value = 1;
        end
        %Bit7 setzen
        Comp_Wert = 128;
        if (max(bitand(Status(Index_Start:end), Comp_Wert)) == Comp_Wert)
            UI.Status_hold_Button7.Value = 1;
        end      
        clear Index_Start
    end
end