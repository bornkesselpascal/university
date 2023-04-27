function main()%Auswählen der Daten

    global Linien UI_Checkboxen Daten Files Path Fig
    
    ActPath = pwd;
    cd ../Daten

    [Files,Path] = uigetfile('*.mat','MATLAB-Datenfiles wählen','MultiSelect','on');
    if ~isnumeric(Files)
        Fig = figure;
        set(Fig,'Color',[1 1 1],'Units','normalized','Position',[0.1 0.1 0.7 0.7])
        Achse = axes;
        set(Achse,'NextPlot','add','Xgrid','on','Ygrid','on','Box','on')
        set(get(Achse,'YLabel'),'String','Winkel [phi]');
        set(get(Achse,'XLabel'),'String','Zeit [s]');

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

        Daten = [];
        for i = 1:Laenge
            FarbCode = FarbCode + 1; 
            %Laden der einzelnen Datenfiles
            if iscell(Files)
                load(fullfile(Path,Files{i}));
            else 
                load(fullfile(Path,Files));
            end

            %Plotten der Linie
            Linien(i) = plot(Zeit,Amplitude,'Color',Farben{FarbCode});

            %Daten auf äuquidistante Zeitachse interpolieren (teilweise fehlen Messpunkte)
            [Zeit_unique,ia,ic] = unique(Zeit);
            Amplitude_unique = Amplitude(ia);
            clear ia ic
            
            Zeit_interp = Zeit_unique(1):0.001:Zeit_unique(end);
            Amplitude_interp = interp1(Zeit_unique,Amplitude_unique,Zeit_interp);

            %Ablegen der interpolierte Daten in einem Array
            if ~isempty(Daten)
                if size(Zeit_interp,2) > size(Daten,2)
                    Zeit_interp(size(Daten,2)+1:end) = [];
                    Amplitude_interp(size(Daten,2)+1:end) = [];
                elseif size(Zeit_interp,2) < size(Daten,2)
                    Daten(:,size(Zeit_interp,2)+1:end) = [];
                end
            end
            
            if i == 1 
                %Beim ersten Durchlauf Zeitachse in erste Zeile
                Daten = cat(1,Daten,Zeit_interp);
            end
            Daten = cat(1,Daten,Amplitude_interp);

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
    end

    %Legende erzeugen
    Legende = legend(Achse,Legenden_Eintraege);
    set(Legende,'Units','pixels');
    Pos_Legende = get(Legende,'Position');
    
    %Erzeugen der UIs
    for i = 1:Laenge
        UI_Checkboxen(i) = uicontrol('Style','checkbox',...
                                     'Position',[Pos_Legende(1)-20 Pos_Legende(2)+Pos_Legende(4)-i*Pos_Legende(4)/Laenge 20 Pos_Legende(4)/Laenge],...
                                     'Callback',@Auswertung_Checkboxen,'Value',1);
    end
    
    UI_ExportMW = uicontrol('Style','pushbutton',...
                            'String','Exportieren',...
                            'Position',[Pos_Legende(1) Pos_Legende(2)+Pos_Legende(4)+5 Pos_Legende(3) 25],...
                            'callback',@plot_Linie_gemittelt);
      
    cd(ActPath)

    clear ActPath Farben i Legenden_Eintraege FarbCode Laenge Daten Zeit_interp Amplitude_interp
end

function plot_Linie_gemittelt(hObject,eventdata)

    global Linien UI_Checkboxen Daten Files Path Fig
    
    Zeilen = [];
    
    for i = 1:length(UI_Checkboxen)
        Checkbox_aktiv = get(UI_Checkboxen(i),'Value');
        if (Checkbox_aktiv == 1)
            Zeilen = cat(1,Zeilen,i+1);
        end
    end

    if ~isempty(Zeilen)
        %Hier Code zum Plotten der gemittelten Linie
        Zeit_MW = Daten(1,:);
        Daten_MW = Daten(Zeilen,:);
        Amplitude_MW = mean(Daten_MW);
        Linie_MW = line(Zeit_MW,Amplitude_MW,'Color',[0 0 0],'LineStyle','--','LineWidth',2);


        % speichern der gemittelten Daten
        Zeit = Zeit_MW;
        Amplitude = Amplitude_MW;
        FileName_MW = Files{1};
        FileName_MW = FileName_MW(1:end-6);
        FileName_MW = [FileName_MW '_MW.mat'];
        FileName_MW = fullfile(Path,FileName_MW);
        [File_MW,Path_MW]= uiputfile('*.mat','gemittelte Daten speichern als ...', FileName_MW);   
        if ~isempty(File_MW)
            save(fullfile(Path_MW,File_MW),'Zeit','Amplitude');
            mydialog
        end
    else
        errordlg('Es sind alle Linien deaktiviert','Fehler');
    end
end

function Auswertung_Checkboxen(hObject,eventdata)
    
    global Linien UI_Checkboxen Daten
    
    for i = 1:length(UI_Checkboxen)
        Checkbox_aktiv = get(UI_Checkboxen(i),'Value');
        if (Checkbox_aktiv == 0)
            set(Linien(i),'Visible','off')
        else
            set(Linien(i),'Visible','on')
        end
    end
end

function mydialog

    d = dialog('units','normalized','Position',[0.8 0.4 0.15 0.2],'Name','Kontrolle');

    txt = uicontrol('Parent',d,...
               'Style','text',...
               'units','normalized',...
               'Position',[0.05 0.4 0.9 0.5],...
               'FontSize',12,...
               'String','Kontrollieren Sie den gemittelten Datenverlauf');

    btn_io = uicontrol('Parent',d,...
               'units','normalized',... 
               'Position',[0.1 0.05 0.4 0.3],...
               'FontSize',10,...
               'String','speichern',...
               'Callback',@Speichern_Figure);
    
    btn_nio = uicontrol('Parent',d,...
               'units','normalized',... 
               'Position',[0.55 0.05 0.4 0.3],...
               'FontSize',10,...
               'String','<html><center>nicht<br>speichern',...
               'Callback',@nicht_Speichern_Figure);       
           
end

function Speichern_Figure(hObject,eventdata)
    
    global Fig Files Path
    
    FileName_Fig = Files{1};
    FileName_Fig = FileName_Fig(1:end-6);
    FileName_Fig = [FileName_Fig '.fig'];
    FileName_Fig = fullfile(Path,FileName_Fig);
    [File_Fig,Path_Fig]= uiputfile('*.fig','Figure speichern als ...', FileName_Fig);
    if ~isempty(File_Fig)
        savefig(Fig,fullfile(Path_Fig,File_Fig));
    end
    delete(Fig);
    delete(gcf);
    
end

function nicht_Speichern_Figure(hObject,eventdata)
    
    global Fig
    
    delete(Fig);
    delete(gcf);
    
end