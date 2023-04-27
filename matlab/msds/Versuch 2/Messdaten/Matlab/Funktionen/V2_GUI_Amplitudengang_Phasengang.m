function V2_GUI_Amplitudengang_Phasengang(Zeit,Kanal_A,Kanal_B,Infos)

    %Figure erzeugen
    %---------------
    Fig = figure;
    c_Fig = 0.95;
    set(Fig,'Color',[c_Fig c_Fig c_Fig],'Units','normalized','Position',[0 0.05 1 0.85]);
    set(Fig,'Name',Infos.fileName)
    clear c_Fig
    
    %Setzen der Einstellungen für den DatenCursor
    dcm = datacursormode(Fig);
    dcm.UpdateFcn = @DataCursorEinst;

    %Achsen und Linien erzeugen
    %--------------------------
    Achsen_links = 0.1;
    Achse_unten = 0.1;
    Achsen_Hoehe = 0.4;
    Achsen_Breite = 0.8;
    Achsen_Abstand = 0.07;
    
    Linienbreite = 2;

    Achse_1 = axes;
    set(Achse_1,'Units','normalized',...
        'Position',[Achsen_links Achse_unten Achsen_Breite Achsen_Hoehe],...
        'Box','on','XGrid','on','YGrid','on','XLim',[min(Zeit) max(Zeit)]);
    set(get(Achse_1,'XLabel'),'String','Zeit [s]');
    set(get(Achse_1,'YLabel'),'String','Spannung U [V]');
    Achse1.NextPlot = 'add';
    
    Linie_U = line(Zeit,Kanal_A,'Parent',Achse_1,'Color','b','LineWidth',Linienbreite);
    Linie_Y = line(Zeit,Kanal_B,'Parent',Achse_1,'Color','r','LineWidth',Linienbreite);
    
    %Legende
    Legendentext{1} = ['Eingang (Amplitude: ' num2str((max(Kanal_A)-min(Kanal_A))/2) ')'];
    Legendentext{2} = ['Ausgang (Amplitude: ' num2str((max(Kanal_B)-min(Kanal_B))/2) ')'];
    Legende = legend(Achse_1,'show');
    Legende.String = Legendentext;
    Legende.Location = 'northwest';
    Legende.FontSize = 12;

    Achse_2 = axes;
    set(Achse_2,'Units','normalized',...
        'Position',[Achsen_links Achse_unten+Achsen_Hoehe+Achsen_Abstand Achsen_Breite Achsen_Hoehe],...
        'Box','on','XGrid','on','YGrid','on','XLim',[min(Zeit) max(Zeit)],'YLim',[-1.1 1.1]);
    set(get(Achse_2,'YLabel'),'String','skaliert [-]');
    Achse2.NextPlot = 'add';

    Linie_U_Scale = line(Zeit,Kanal_A/max(Kanal_A),'Parent',Achse_2,'Color','b','LineWidth',Linienbreite);
    Linie_Y_Scale = line(Zeit,Kanal_B/max(Kanal_B),'Parent',Achse_2,'Color','r','LineWidth',Linienbreite);
    
    linkaxes([Achse_1,Achse_2], 'x');
    
    %Zoom-Einstellungen
    Zoom_Handle = zoom(Fig);
    Zoom_Handle.Enable = 'on';
    %Zoom_Handle.Motion  = 'Horizontal';
end