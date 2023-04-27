function V2_GUI_Daempfung(Zeit,Kanal_A,Kanal_B,Infos)

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
    Linienbreite = 2;

    Achse_1 = axes;
    set(Achse_1,'Units','normalized',...
        'Position',[0.1 0.1 0.8 0.8],...
        'Box','on','XGrid','on','YGrid','on','XLim',[min(Zeit) max(Zeit)]);
    set(get(Achse_1,'XLabel'),'String','Zeit [s]','FontSize',14);
    set(get(Achse_1,'YLabel'),'String','Spannung U [V]','FontSize',14);
    Achse1.NextPlot = 'add';
    yyaxis(Achse_1,'left')
    Linie_U = line(Zeit,Kanal_A,'Parent',Achse_1,'Color','b','LineWidth',Linienbreite);
    
    yyaxis(Achse_1,'right')
    set(get(gca,'YLabel'),'String','Spannung U [V]','FontSize',14);
    Linie_Y = line(Zeit,Kanal_B,'Parent',Achse_1,'Color','r','LineWidth',Linienbreite);
    
    
    %Legende
    Legendentext{1} = ['Eingang'];
    Legendentext{2} = ['Ausgang'];
    Legende = legend(Achse_1,'show');
    Legende.String = Legendentext;
    Legende.Location = 'northwest';
    Legende.FontSize = 12;
    
    %Zoom-Einstellungen
    Zoom_Handle = zoom(Fig);
    Zoom_Handle.Enable = 'on';
    Zoom_Handle.Motion  = 'Horizontal';
end