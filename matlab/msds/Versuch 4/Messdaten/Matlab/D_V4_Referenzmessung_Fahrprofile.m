function main()%Auswählen der Daten

    global Linien UI Daten Files Path Fig Achse xPos_Limit_Face
    
    ActPath = pwd;
    cd ../Daten

    [Files,Path] = uigetfile('*.mat','MATLAB-Datenfiles wählen','MultiSelect','on');
    if ~isnumeric(Files)
        Fig = figure;
        set(Fig,'Color',[1 1 1],'Units','normalized','Position',[0.1 0 0.7 0.9],'DeleteFcn','clear all')
        Achse.PWM = axes;
        set(Achse.PWM,'NextPlot','add','Xgrid','on','Ygrid','on','Box','on','Position',[0.1 0.7 0.8 0.28])
        set(get(Achse.PWM,'YLabel'),'String','Ansteuerung EM [-]');
        %set(get(Achse.x,'XLabel'),'String','Zeit [s]');
        set(Achse.PWM,'XTickLabels',[]);
        
        Achse.x = axes;
        set(Achse.x,'NextPlot','add','Xgrid','on','Ygrid','on','Box','on','Position',[0.1 0.4 0.8 0.28])
        set(get(Achse.x,'YLabel'),'String','Weg [mm]');
        %set(get(Achse.x,'XLabel'),'String','Zeit [s]');
        set(Achse.x,'XTickLabels',[]);
        
        Achse.v = axes;
        set(Achse.v,'NextPlot','add','Xgrid','on','Ygrid','on','Box','on','Position',[0.1 0.1 0.8 0.28])
        set(get(Achse.v,'YLabel'),'String','Geschwindigkeit [m/s]');
        set(get(Achse.v,'XLabel'),'String','Zeit [s]');
        
        linkaxes([Achse.PWM,Achse.x,Achse.v], 'x');
        zoom xon

        Farben{1} = [0 0 1];        %blau
        Farben{2} = [1 0 0];        %rot
        Farben{3} = [0 0.5 0];      %grün
        Farben{4} = [0.9 0.5 0];    %orange
        Farben{5} = [1 0 1];        %magenta
        Farben{6} = [0 1 1];        %cyan
        Farben{7} = [0.5 0.5 0.5];  %grau
        FarbCode = 0;

        if iscell(Files)
            Laenge = length(Files);
        else
            Laenge = 1;
        end

        %Daten = [];
        for i = 1:Laenge
            FarbCode = FarbCode + 1; 
            %Laden der einzelnen Datenfiles
            if iscell(Files)
                load(fullfile(Path,Files{i}));
            else 
                load(fullfile(Path,Files));
            end
            
            % Varianten-Auswahl: 1 - lineare Messgrößen, 2 - rotatorische Messgrößen 
            Variante = 2;
            if Variante == 1
                x_plot = x_lin;
                v_plot = v_lin;
            elseif Variante == 2
                x_plot = x_rot;
                v_plot = v_rot;
            end
            
            
            %Linien auf Referenzpunkt synchronisieren
            Variante = 2;
            if Variante == 1
                vRefPunkt = 0.2; %Alle Messungen werden auf diesen Geschwindigkeitspunkt in [m/s] synchronisiert
                Index_Ref = find(v_plot >= vRefPunkt,1);
            elseif Variante == 2
                Index_Ref = find(x_plot <= min(x_plot),1);
            end
            Zeit_Ref = Zeit(Index_Ref);
            Zeit = Zeit - Zeit_Ref;
            clear vRefPunkt Index_Ref Zeit_Ref

            %Plotten der Linien
            Linien.Messung(i).x = plot(Achse.x,Zeit,x_plot,'Color',Farben{FarbCode});
            Linien.Messung(i).v = plot(Achse.v,Zeit,v_plot,'Color',Farben{FarbCode});

            %äuquidistante Zeitachse erzeugen (teilweise kleinere Ungenauigkeiten in Zeitwerten)            
            deltaT = 0.025;
            Zeit_interp_min = round(Zeit(1)/deltaT)*deltaT;
            Zeit_interp_max = round(Zeit(end)/deltaT)*deltaT;
            
            Daten.Messung(i).Zeit_interp = Zeit_interp_min:deltaT:Zeit_interp_max;
            Daten.Messung(i).Zeit_interp = round(Daten.Messung(i).Zeit_interp,3);
            
            %Daten auf äuquidistante Zeitachse interpolieren
            Daten.Messung(i).x_plot_interp = interp1(Zeit,x_plot,Daten.Messung(i).Zeit_interp);
            Daten.Messung(i).v_plot_interp = interp1(Zeit,v_plot,Daten.Messung(i).Zeit_interp);
            Daten.Messung(i).a_interp = interp1(Zeit,a,Daten.Messung(i).Zeit_interp);
            Daten.Messung(i).a_x_interp = interp1(Zeit,a_x,Daten.Messung(i).Zeit_interp);
            Daten.Messung(i).a_z_interp = interp1(Zeit,a_z,Daten.Messung(i).Zeit_interp);
            Daten.Messung(i).PWM_EM_interp = interp1(Zeit,PWM_EM,Daten.Messung(i).Zeit_interp);
            Daten.Messung(i).U_B_interp = interp1(Zeit,U_B,Daten.Messung(i).Zeit_interp);
            Daten.Messung(i).Status_interp = interp1(Zeit,Status,Daten.Messung(i).Zeit_interp);
            Daten.Messung(i).i_A_interp = interp1(Zeit,i_A,Daten.Messung(i).Zeit_interp);
            Daten.Messung(i).v_lin_interp = interp1(Zeit,v_lin,Daten.Messung(i).Zeit_interp);
            Daten.Messung(i).v_rot_interp = interp1(Zeit,v_rot,Daten.Messung(i).Zeit_interp);
            Daten.Messung(i).x_lin_interp = interp1(Zeit,x_lin,Daten.Messung(i).Zeit_interp);
            Daten.Messung(i).x_rot_interp = interp1(Zeit,x_rot,Daten.Messung(i).Zeit_interp);
            
            Linien.Messung(i).PWM = plot(Achse.PWM,Daten.Messung(i).Zeit_interp,Daten.Messung(i).PWM_EM_interp,'Color',Farben{FarbCode});
            
            clear deltaT Zeit_interp_min Zeit_interp_max Zeit a a_x a_z U_B Status i_A v_lin v_rot x_lin x_rot PWM_EM
            
            % Bestimmung der Start und Stopzeit für die Darstellung im Plot
            if i == 1
                Daten.StartZeit = Daten.Messung(i).Zeit_interp(1);
                Daten.StopZeit = Daten.Messung(i).Zeit_interp(end);
            else
                if (Daten.Messung(i).Zeit_interp(1) > Daten.StartZeit)
                    Daten.StartZeit = Daten.Messung(i).Zeit_interp(1);
                end
                
                if (Daten.Messung(i).Zeit_interp(end) < Daten.StopZeit)
                    Daten.StopZeit = Daten.Messung(i).Zeit_interp(end);
                end
            end

            %Erzeugen der Legendeneinträge
            if iscell(Files)
                Legenden_Eintraege{i} = strrep(Files{i},'_','\_');
            else 
                Legenden_Eintraege{i} = strrep(Files,'_','\_');
            end
            if FarbCode == length(Farben)
                FarbCode = 0;
            end
            
        end 
    
        %nicht benötigte Werte aus den Messdaten entfernen;
        for i = 1:Laenge
            if (Daten.Messung(i).Zeit_interp(1) < Daten.StartZeit)
                Index_Start = find(Daten.Messung(i).Zeit_interp >= Daten.StartZeit,1);
            else
                Index_Start = 1;
            end
            if (Daten.Messung(i).Zeit_interp(end) > Daten.StopZeit)
                Index_Stop = find(Daten.Messung(i).Zeit_interp >= Daten.StopZeit,1);
            else
                Index_Stop = length(Daten.Messung(i).Zeit_interp);
            end
            
            if (~isempty(Index_Start) && ~isempty(Index_Stop))
                Daten.Messung(i).Zeit_interp = Daten.Messung(i).Zeit_interp(Index_Start:Index_Stop);
                Daten.Messung(i).x_plot_interp = Daten.Messung(i).x_plot_interp(Index_Start:Index_Stop);
                Daten.Messung(i).v_plot_interp = Daten.Messung(i).v_plot_interp(Index_Start:Index_Stop);
                Daten.Messung(i).a_interp = Daten.Messung(i).a_interp(Index_Start:Index_Stop);
                Daten.Messung(i).a_x_interp = Daten.Messung(i).a_x_interp(Index_Start:Index_Stop);
                Daten.Messung(i).a_z_interp = Daten.Messung(i).a_z_interp(Index_Start:Index_Stop);
                Daten.Messung(i).PWM_EM_interp = Daten.Messung(i).PWM_EM_interp(Index_Start:Index_Stop);
                Daten.Messung(i).U_B_interp = Daten.Messung(i).U_B_interp(Index_Start:Index_Stop);
                Daten.Messung(i).Status_interp = Daten.Messung(i).Status_interp(Index_Start:Index_Stop);
                Daten.Messung(i).i_A_interp = Daten.Messung(i).i_A_interp(Index_Start:Index_Stop);
                Daten.Messung(i).v_lin_interp = Daten.Messung(i).v_lin_interp(Index_Start:Index_Stop);
                Daten.Messung(i).v_rot_interp = Daten.Messung(i).v_rot_interp(Index_Start:Index_Stop);
                Daten.Messung(i).x_lin_interp = Daten.Messung(i).x_lin_interp(Index_Start:Index_Stop);
                Daten.Messung(i).x_rot_interp = Daten.Messung(i).x_rot_interp(Index_Start:Index_Stop);
                clear Index_Start Index_Stop
            else
                disp(['offenbar ist ein Fehler bei Messung ' num2str(i) ' aufgetreten!!'])
            end
        end
        
        % gemittelten Verlauf berechnen
        if Laenge > 1
            for i = 1:Laenge
                if i == 1
                    Array.Zeit_MW = Daten.Messung(i).Zeit_interp;
                    Array.x_plot_MW = Daten.Messung(i).x_plot_interp;
                    Array.v_plot_MW = Daten.Messung(i).v_plot_interp;
                    Array.a_MW = Daten.Messung(i).a_interp;
                    Array.a_x_MW = Daten.Messung(i).a_x_interp;
                    Array.a_z_MW = Daten.Messung(i).a_z_interp;
                    Array.PWM_EM_MW = Daten.Messung(i).PWM_EM_interp;
                    Array.U_B_MW = Daten.Messung(i).U_B_interp;
                    Array.Status_MW = Daten.Messung(i).Status_interp;
                    Array.i_A_MW = Daten.Messung(i).i_A_interp;
                    Array.v_lin_MW = Daten.Messung(i).v_lin_interp;
                    Array.v_rot_MW = Daten.Messung(i).v_rot_interp;
                    Array.x_lin_MW = Daten.Messung(i).x_lin_interp;
                    Array.x_rot_MW = Daten.Messung(i).x_rot_interp;
                else
                    Array.Zeit_MW = cat(1,Array.Zeit_MW,Daten.Messung(i).Zeit_interp);
                    Array.x_plot_MW = cat(1,Array.x_plot_MW,Daten.Messung(i).x_plot_interp);
                    Array.v_plot_MW = cat(1,Array.v_plot_MW,Daten.Messung(i).v_plot_interp);
                    Array.a_MW = cat(1,Array.a_MW,Daten.Messung(i).a_interp);
                    Array.a_x_MW = cat(1,Array.a_x_MW,Daten.Messung(i).a_x_interp);
                    Array.a_z_MW = cat(1,Array.a_z_MW,Daten.Messung(i).a_z_interp);
                    Array.PWM_EM_MW = cat(1,Array.PWM_EM_MW,Daten.Messung(i).PWM_EM_interp);
                    Array.U_B_MW = cat(1,Array.U_B_MW,Daten.Messung(i).U_B_interp);
                    Array.Status_MW = cat(1,Array.Status_MW,Daten.Messung(i).Status_interp);
                    Array.i_A_MW = cat(1,Array.i_A_MW,Daten.Messung(i).i_A_interp);
                    Array.v_lin_MW = cat(1,Array.v_lin_MW,Daten.Messung(i).v_lin_interp);
                    Array.v_rot_MW = cat(1,Array.v_rot_MW,Daten.Messung(i).v_rot_interp);
                    Array.x_lin_MW = cat(1,Array.x_lin_MW,Daten.Messung(i).x_lin_interp);
                    Array.x_rot_MW = cat(1,Array.x_rot_MW,Daten.Messung(i).x_rot_interp);
                end
            end
            Daten.Zeit_interp_MW = mean(Array.Zeit_MW);
            Daten.x_plot_interp_MW = mean(Array.x_plot_MW);
            Daten.v_plot_interp_MW = mean(Array.v_plot_MW);
            Daten.a_interp_MW = mean(Array.a_MW);
            Daten.a_x_interp_MW = mean(Array.a_x_MW);
            Daten.a_z_interp_MW = mean(Array.a_z_MW);
            Daten.PWM_EM_interp_MW = mean(Array.PWM_EM_MW);
            Daten.U_B_interp_MW = mean(Array.U_B_MW);
            Daten.Status_interp_MW = mean(Array.Status_MW);
            Daten.i_A_interp_MW = mean(Array.i_A_MW);
            Daten.v_lin_interp_MW = mean(Array.v_lin_MW);
            Daten.v_rot_interp_MW = mean(Array.v_rot_MW);
            Daten.x_lin_interp_MW = mean(Array.x_lin_MW);
            Daten.x_rot_interp_MW = mean(Array.x_rot_MW);
        elseif Laenge == 1
            Daten.Zeit_interp_MW = Daten.Messung(1).Zeit_interp;
            Daten.x_plot_interp_MW = Daten.Messung(1).x_plot_interp;
            Daten.v_plot_interp_MW = Daten.Messung(1).v_plot_interp;
            Daten.a_interp_MW = Daten.Messung(1).a_interp;
            Daten.a_x_interp_MW = Daten.Messung(1).a_x_interp;
            Daten.a_z_interp_MW = Daten.Messung(1).a_z_interp;
            Daten.PWM_EM_interp_MW = Daten.Messung(1).PWM_EM_interp;
            Daten.U_B_interp_MW = Daten.Messung(1).U_B_interp;
            Daten.Status_interp_MW = Daten.Messung(1).Status_interp;
            Daten.i_A_interp_MW = Daten.Messung(1).i_A_interp;
            Daten.v_lin_interp_MW = Daten.Messung(1).v_lin_interp;
            Daten.v_rot_interp_MW = Daten.Messung(1).v_rot_interp;
            Daten.x_lin_interp_MW = Daten.Messung(1).x_lin_interp;
            Daten.x_rot_interp_MW = Daten.Messung(1).x_rot_interp;
        end
        
        %Rollphase bestimmen und reinzoomen
        %Index_Start = find(Daten.v_plot_interp_MW >= 
            
        
        %gemittelte Verläufe plotten
        Linien.MW_x = plot(Achse.x,Daten.Zeit_interp_MW,Daten.x_plot_interp_MW,'Color','k','LineWidth',2,'LineStyle','--');
        Linien.MW_v = plot(Achse.v,Daten.Zeit_interp_MW,Daten.v_plot_interp_MW,'Color','k','LineWidth',2,'LineStyle','--');
        Linien.MW_PWM = plot(Achse.PWM,Daten.Zeit_interp_MW,Daten.PWM_EM_interp_MW,'Color','k','LineWidth',2,'LineStyle','--');
        

        %Legende erzeugen
        Legende = legend(Achse.PWM,Legenden_Eintraege,'Location','northeastoutside');
        set(Legende,'Units','pixels');
        Pos_Legende = get(Legende,'Position');

        %x-Achsen der Plots korrekt einstellen
        Achse.x.XLim = [Daten.StartZeit Daten.StopZeit];
        Achse.v.XLim = [Daten.StartZeit Daten.StopZeit];
        Achse.PWM.XLim = [Daten.StartZeit Daten.StopZeit];

        %Achsensysemte in ihrer Position synchronisieren
        Pos_Achse_i = Achse.PWM.Position;
        Pos_Achse_x = Achse.x.Position;
        Pos_Achse_x(1) = Pos_Achse_i(1);
        Pos_Achse_x(3) = Pos_Achse_i(3);
        Achse.x.Position = Pos_Achse_x;
        Pos_Achse_v = Achse.v.Position;
        Pos_Achse_v(1) = Pos_Achse_i(1);
        Pos_Achse_v(3) = Pos_Achse_i(3);
        Achse.v.Position = Pos_Achse_v;
        clear Pos_Achse_x Pos_Achse_v
            
        %Erzeugen der UIs
        for i = 1:Laenge
            UI.Checkboxen(i) = uicontrol('Style','checkbox',...
                                         'Position',[Pos_Legende(1)+Pos_Legende(3)+10 Pos_Legende(2)+Pos_Legende(4)-i*Pos_Legende(4)/Laenge 20 Pos_Legende(4)/Laenge],...
                                         'Callback',@Auswertung_Checkboxen,'Value',1,'BackgroundColor',[1 1 1]);
        end

        UI.Aktualisieren = uicontrol('Style','pushbutton',...
                                'String','Ansicht aktualisieren',...
                                'Position',[Pos_Legende(1) Pos_Legende(2)-30 Pos_Legende(3) 25],...
                                'callback',@Ansicht_aktualisieren);
        UI.Aktualisieren.Visible = 'off';                    
                            
        UI.Exportieren = uicontrol('Style','pushbutton',...
                                'String','Daten exportieren',...
                                'Position',[Pos_Legende(1) Pos_Legende(2)-60 Pos_Legende(3) 25],...
                                'callback',@Daten_exportieren);                    
                            
        UI.xPos_Limit_text = uicontrol('Style','text',...
                                        'String','Schwellwert Position','Units','normalized',...
                                        'Position',[Achse.x.Position(1)+Achse.x.Position(3)+0.02 Achse.x.Position(2)+Achse.x.Position(4)/2+0.05 0.15 0.03],...
                                        'FontSize',14,'BackgroundColor',[1 1 1]);
                            
        UI.xPos_Limit_edit = uicontrol('Style','edit',...
                                        'String','1100','Units','normalized',...
                                        'Position',[Achse.x.Position(1)+Achse.x.Position(3)+0.04 Achse.x.Position(2)+Achse.x.Position(4)/2 0.1 0.05],...
                                        'callback',@xPos_Limit_festlegen,'FontSize',16);        
                                    
        x_patch = [Daten.Zeit_interp_MW(1) Daten.Zeit_interp_MW(end) Daten.Zeit_interp_MW(end) Daten.Zeit_interp_MW(1)];
        y_patch = [str2num(UI.xPos_Limit_edit.String) str2num(UI.xPos_Limit_edit.String) Achse.x.YLim(2) Achse.x.YLim(2)];
        xPos_Limit_Face = patch(Achse.x,'XData',x_patch,'YData',y_patch,'FaceColor','red','FaceAlpha',0.2,'EdgeColor','none');
        clear x_patch y_patch
        
        Ansicht_aktualisieren(0,0)
    
        cd(ActPath)

        clear ActPath Farben i Legenden_Eintraege FarbCode Laenge Daten Zeit_interp x_plot_interp
    end
end

function Ansicht_aktualisieren(hObject,eventdata)

    global UI Daten Files Path Fig Achse
    
    Zeilen = [];
    
    for i = 1:length(UI.Checkboxen)
        Checkbox_aktiv = get(UI.Checkboxen(i),'Value');
        if (Checkbox_aktiv == 1)
            Zeilen = cat(1,Zeilen,i+1);
        end
    end
    
    Index_Start = find(Daten.PWM_EM_interp_MW > 1,1);
    
    Index_Temp = find(Daten.PWM_EM_interp_MW > 1,1,'last');
    
    Schwelle_x_plot = str2num(UI.xPos_Limit_edit.String);
    Index_Stop = find(Daten.x_plot_interp_MW >= Schwelle_x_plot);
    Index_Stop = Index_Stop(find(Index_Stop > Index_Temp,1));
    if isempty(Index_Stop)
        Index_Stop = length(Daten.x_plot_interp_MW);
    end
    
    set(Achse.PWM,'XLim',[Daten.Zeit_interp_MW(Index_Start) Daten.Zeit_interp_MW(Index_Stop)]);
    set(Achse.x,'XLim',[Daten.Zeit_interp_MW(Index_Start) Daten.Zeit_interp_MW(Index_Stop)]);
    set(Achse.v,'XLim',[Daten.Zeit_interp_MW(Index_Start) Daten.Zeit_interp_MW(Index_Stop)]);
    
    Daten.Index_Start = Index_Start;
    Daten.Index_Stop = Index_Stop;
end

function Daten_exportieren(hObject,eventdata)

    global UI Daten Files Path Fig Achse
    
    Zeilen = [];
    
    for i = 1:length(UI.Checkboxen)
        Checkbox_aktiv = get(UI.Checkboxen(i),'Value');
        if (Checkbox_aktiv == 1)
            Zeilen = cat(1,Zeilen,i+1);
        end
    end

    if ~isempty(Zeilen)
        Index_Start = Daten.Index_Start;
        Index_Stop = Daten.Index_Stop;
        
        % speichern der gemittelten Daten
        Zeit = Daten.Zeit_interp_MW(Index_Start:Index_Stop)'-Daten.Zeit_interp_MW(Index_Start);
        a = Daten.a_interp_MW(Index_Start:Index_Stop)';
        a_x = Daten.a_x_interp_MW(Index_Start:Index_Stop)';
        a_z = Daten.a_z_interp_MW(Index_Start:Index_Stop)';
        PWM_EM = Daten.PWM_EM_interp_MW(Index_Start:Index_Stop)';
        U_B = Daten.U_B_interp_MW(Index_Start:Index_Stop)';
        Status = Daten.Status_interp_MW(Index_Start:Index_Stop)';
        i_A = Daten.i_A_interp_MW(Index_Start:Index_Stop)';
        v_lin = Daten.v_lin_interp_MW(Index_Start:Index_Stop)';
        v_rot = Daten.v_rot_interp_MW(Index_Start:Index_Stop)';
        x_lin = Daten.x_lin_interp_MW(Index_Start:Index_Stop)';
        x_rot = Daten.x_rot_interp_MW(Index_Start:Index_Stop)';
        
        if iscell(Files)
            FileName_MW = Files{1};
        else
           FileName_MW = Files;
        end
        FileName_MW = FileName_MW(1:end-6);
        FileName_MW = [FileName_MW '_Ref.mat'];
        FileName_MW = fullfile(Path,FileName_MW);
        [File_MW,Path_MW]= uiputfile('*.mat','gemittelte Daten speichern als ...', FileName_MW);   
        if ~isnumeric(File_MW)
            save(fullfile(Path_MW,File_MW),'Zeit','a','a_x','a_z','PWM_EM','U_B','Status','i_A','v_lin','v_rot','x_lin','x_rot');
            %delete(Fig)
            %clear all
        end
    else
        errordlg('Es sind alle Linien deaktiviert','Fehler');
    end

end



function Auswertung_Checkboxen(hObject,eventdata)
    
    global Linien UI Daten
    
    Zeilen = [];
    for i = 1:length(UI.Checkboxen)
        Checkbox_aktiv = get(UI.Checkboxen(i),'Value');
        if (Checkbox_aktiv == 0)
            set(Linien.Messung(i).PWM,'Visible','off')
            set(Linien.Messung(i).x,'Visible','off')
            set(Linien.Messung(i).v,'Visible','off')
        else
            set(Linien.Messung(i).PWM,'Visible','on')
            set(Linien.Messung(i).x,'Visible','on')
            set(Linien.Messung(i).v,'Visible','on')
            Zeilen = cat(2,Zeilen,i);
        end
    end
    
    % gemittelten Verlauf berechnen
    if ~isempty(Zeilen)
        if length(Zeilen) > 1
            for i = Zeilen
                if i == Zeilen(1);
                    Array.Zeit_MW = Daten.Messung(i).Zeit_interp;
                    Array.x_plot_MW = Daten.Messung(i).x_plot_interp;
                    Array.v_plot_MW = Daten.Messung(i).v_plot_interp;
                    Array.a_MW = Daten.Messung(i).a_interp;
                    Array.a_x_MW = Daten.Messung(i).a_x_interp;
                    Array.a_z_MW = Daten.Messung(i).a_z_interp;
                    Array.PWM_EM_MW = Daten.Messung(i).PWM_EM_interp;
                    Array.U_B_MW = Daten.Messung(i).U_B_interp;
                    Array.Status_MW = Daten.Messung(i).Status_interp;
                    Array.i_A_MW = Daten.Messung(i).i_A_interp;
                    Array.v_lin_MW = Daten.Messung(i).v_lin_interp;
                    Array.v_rot_MW = Daten.Messung(i).v_rot_interp;
                    Array.x_lin_MW = Daten.Messung(i).x_lin_interp;
                    Array.x_rot_MW = Daten.Messung(i).x_rot_interp;
                else
                    Array.Zeit_MW = cat(1,Array.Zeit_MW,Daten.Messung(i).Zeit_interp);
                    Array.x_plot_MW = cat(1,Array.x_plot_MW,Daten.Messung(i).x_plot_interp);
                    Array.v_plot_MW = cat(1,Array.v_plot_MW,Daten.Messung(i).v_plot_interp);
                    Array.a_MW = cat(1,Array.a_MW,Daten.Messung(i).a_interp);
                    Array.a_x_MW = cat(1,Array.a_x_MW,Daten.Messung(i).a_x_interp);
                    Array.a_z_MW = cat(1,Array.a_z_MW,Daten.Messung(i).a_z_interp);
                    Array.PWM_EM_MW = cat(1,Array.PWM_EM_MW,Daten.Messung(i).PWM_EM_interp);
                    Array.U_B_MW = cat(1,Array.U_B_MW,Daten.Messung(i).U_B_interp);
                    Array.Status_MW = cat(1,Array.Status_MW,Daten.Messung(i).Status_interp);
                    Array.i_A_MW = cat(1,Array.i_A_MW,Daten.Messung(i).i_A_interp);
                    Array.v_lin_MW = cat(1,Array.v_lin_MW,Daten.Messung(i).v_lin_interp);
                    Array.v_rot_MW = cat(1,Array.v_rot_MW,Daten.Messung(i).v_rot_interp);
                    Array.x_lin_MW = cat(1,Array.x_lin_MW,Daten.Messung(i).x_lin_interp);
                    Array.x_rot_MW = cat(1,Array.x_rot_MW,Daten.Messung(i).x_rot_interp);
                end
            end
            Daten.Zeit_interp_MW = mean(Array.Zeit_MW);
            Daten.x_plot_interp_MW = mean(Array.x_plot_MW);
            Daten.v_plot_interp_MW = mean(Array.v_plot_MW);
            Daten.a_interp_MW = mean(Array.a_MW);
            Daten.a_x_interp_MW = mean(Array.a_x_MW);
            Daten.a_z_interp_MW = mean(Array.a_z_MW);
            Daten.PWM_EM_interp_MW = mean(Array.PWM_EM_MW);
            Daten.U_B_interp_MW = mean(Array.U_B_MW);
            Daten.Status_interp_MW = mean(Array.Status_MW);
            Daten.i_A_interp_MW = mean(Array.i_A_MW);
            Daten.v_lin_interp_MW = mean(Array.v_lin_MW);
            Daten.v_rot_interp_MW = mean(Array.v_rot_MW);
            Daten.x_lin_interp_MW = mean(Array.x_lin_MW);
            Daten.x_rot_interp_MW = mean(Array.x_rot_MW);
        elseif length(Zeilen) == 1
            Daten.Zeit_interp_MW = Daten.Messung(Zeilen).Zeit_interp;
            Daten.x_plot_interp_MW = Daten.Messung(Zeilen).x_plot_interp;
            Daten.v_plot_interp_MW = Daten.Messung(Zeilen).v_plot_interp;
            Daten.a_interp_MW = Daten.Messung(Zeilen).a_interp;
            Daten.a_x_interp_MW = Daten.Messung(Zeilen).a_x_interp;
            Daten.a_z_interp_MW = Daten.Messung(Zeilen).a_z_interp;
            Daten.PWM_EM_interp_MW = Daten.Messung(Zeilen).PWM_EM_interp;
            Daten.U_B_interp_MW = Daten.Messung(Zeilen).U_B_interp;
            Daten.Status_interp_MW = Daten.Messung(Zeilen).Status_interp;
            Daten.i_A_interp_MW = Daten.Messung(Zeilen).i_A_interp;
            Daten.v_lin_interp_MW = Daten.Messung(Zeilen).v_lin_interp;
            Daten.v_rot_interp_MW = Daten.Messung(Zeilen).v_rot_interp;
            Daten.x_lin_interp_MW = Daten.Messung(Zeilen).x_lin_interp;
            Daten.x_rot_interp_MW = Daten.Messung(Zeilen).x_rot_interp;
        end
        
        %gemittelte Verläufe updaten
        Linien.MW_PWM.XData = Daten.Zeit_interp_MW;
        Linien.MW_PWM.YData = Daten.PWM_EM_interp_MW;
        Linien.MW_x.XData = Daten.Zeit_interp_MW;
        Linien.MW_x.YData = Daten.x_plot_interp_MW;
        Linien.MW_v.XData = Daten.Zeit_interp_MW;
        Linien.MW_v.YData = Daten.v_plot_interp_MW;
        
        Ansicht_aktualisieren(0,0)
    end
end

function xPos_Limit_festlegen(hObject,eventdata)

    global Daten Achse xPos_Limit_Face
        
    min_Schwelle = 700;

    Wert = str2num(hObject.String);
    
    if Wert > max(Daten.x_plot_interp_MW)
        Wert = max(Daten.x_plot_interp_MW);
    elseif Wert < min_Schwelle
        Wert = min_Schwelle;
    end
    hObject.String = num2str(Wert,'%4.0f');
    
    x_patch = [Daten.Zeit_interp_MW(1) Daten.Zeit_interp_MW(end) Daten.Zeit_interp_MW(end) Daten.Zeit_interp_MW(1)];
    y_patch = [Wert Wert Achse.x.YLim(2) Achse.x.YLim(2)];
    xPos_Limit_Face.XData = x_patch;
    xPos_Limit_Face.YData = y_patch;
    clear x_patch y_patch
    
    Ansicht_aktualisieren(0,0)

end