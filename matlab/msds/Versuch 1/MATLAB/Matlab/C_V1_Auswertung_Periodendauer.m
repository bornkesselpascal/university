function V1_Auswertung_Periodendauer()

    %Filde auswählen
    %---------------
    ActPath = pwd;
    cd ../Daten

    %Laden der Daten
    [File,Path] = uigetfile({'*.mat','Messdaten-Files (*.mat)'},'Wählen Sie ein Messdaten-File');
    cd(ActPath)

    if ~isnumeric(File)
        load(fullfile(Path,File));
        Infos.fileName = File;

        clear File Path ActPath
    
        %Figure erzeugen
        %---------------
        Fig = figure;
        c_Fig = 0.95;
        set(Fig,'Color',[c_Fig c_Fig c_Fig],'Units','normalized','Position',[0 0.06 1 0.84]);
        set(Fig,'Name',Infos.fileName)
        clear c_Fig

        %Setzen der Einstellungen für den DatenCursor
        dcm = datacursormode(Fig);
        dcm.UpdateFcn = @DataCursorEinst;

        %Periodendauern auswerten
        %------------------------
        [T_Amp,T_Dauer] = Auswertung_Periodendauern(Zeit,Amplitude);
        %Fitpolynom berechnen
        n = 3;
        p = polyfit(T_Amp,T_Dauer,n);
        x_fit = linspace(min(T_Amp),max(T_Amp),100);
        y_fit = polyval(p,x_fit);
        %Zwischenwerte berechnen
        x_ZW = linspace(min(T_Amp),max(T_Amp),5);
        y_ZW = polyval(p,x_ZW);

        %Achsen und Linien erzeugen
        %--------------------------
        Achse_1 = axes;
        set(Achse_1,'Units','normalized',...
            'Box','on','XGrid','on','YGrid','on','XLim',[min(Zeit) max(Zeit)]);
        set(get(Achse_1,'XLabel'),'String','Zeit [s]','FontSize',14);
        set(get(Achse_1,'YLabel'),'String','Auslenkung [°]','FontSize',14);
        Linie_1 = line(Zeit,Amplitude,'Parent',Achse_1,'Color','b','LineWidth',2);
        
        %2. Figure erzeugen
        %------------------
        Fig_2 = figure;
        c_Fig = 0.95;
        set(Fig_2,'Color',[c_Fig c_Fig c_Fig],'Units','normalized','Position',[0 0.06 1 0.84]);
        set(Fig_2,'Name',Infos.fileName)
        clear c_Fig
        
        Achse_2 = axes;
        set(Achse_2,'Units','normalized',...
            'Box','on','XGrid','on','YGrid','on','XLim',[min(T_Amp) max(T_Amp)]);
        set(get(Achse_2,'XLabel'),'String','Amplitude [°]','FontSize',14);
        set(get(Achse_2,'YLabel'),'String','Periodendauer [s]','FontSize',14);
        Linie_2 = line(T_Amp,T_Dauer,'Parent',Achse_2,'LineStyle','none','Marker','o','MarkerEdgeColor','b','MarkerSize',6);
        Linie_2_fit = line(x_fit,y_fit,'Parent',Achse_2,'Color','k','LineWidth',2);
        Linie_2_ZW = line(x_ZW,y_ZW,'Parent',Achse_2,'LineStyle','none','Marker','d','MarkerEdgeColor','r','MarkerFaceColor','r','MarkerSize',10);
        
        %Zoom-Einstellungen
        Zoom_Handle = zoom(Fig);
        set(Zoom_Handle,'Enable','on');
    end
        
end

function output_txt = DataCursorEinst(obj,event_obj)
    % Display the position of the data cursor
    % obj          Currently not used (empty)
    % event_obj    Handle to event object
    % output_txt   Data cursor text string (string or cell array of strings).

    Digits = '%.4f';

    pos = get(event_obj,'Position');
    output_txt = {['t: ',num2str(pos(1),Digits)],...
        ['Y: ',num2str(pos(2),Digits)]};

    % If there is a Z-coordinate in the position, display it as well
    if length(pos) > 2
        output_txt{end+1} = ['Z: ',num2str(pos(3),Digits)];
    end
end

function [T_Amp,T_Dauer] = Auswertung_Periodendauern(Zeit,Amplitude)
    T_Amp = [];
    T_Dauer = [];
    %Bildung eines gleitenden Mittelwerts des Verlaufs um "doppelte"
    %Nulldurchgänge rauszufiltern
    k = 25; % Anzahl der Werte über die gemittelt werden soll
    Amplitude_glMW = movmean(Amplitude,k);
    %Ermittlung Indizes der Nulldurchgänge
    binSig = sign(Amplitude_glMW);
    diff_binSig = cat(2,0,diff(binSig));
    Indizes = find(abs(diff_binSig)>1);
    diff_binSig(Indizes) = 0.5*diff_binSig(Indizes);
    Indizes = find(diff_binSig < 0);
    % Ermittlung der Periodendauer und der zugehörigen max. Auslenkungen
    % ==================================================================
    for i = 2:length(Indizes)
        Amplitude_Temp = Amplitude(Indizes(i-1):Indizes(i));
        if (max(abs(Amplitude_Temp)) > 5)
            T_Amp = cat(2,T_Amp,max(abs(Amplitude_Temp)));
            T_Dauer = cat(2,T_Dauer,Zeit(Indizes(i))-Zeit(Indizes(i-1)));
        end
    end
end