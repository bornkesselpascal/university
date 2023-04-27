function V2_GUI_Zeitkonstante_Kondensator(Zeit,Spannung_Vers,Spannung_Kond,Infos)

    %Figure erzeugen
    %---------------
    Fig = figure;
    c_Fig = 0.95;
    set(Fig,'Color',[c_Fig c_Fig c_Fig],'Units','normalized','Position',[0.3 0.1 0.45 0.8]);
    set(Fig,'Name',Infos.fileName)
    clear c_Fig
    
    %Setzen der Einstellungen für den DatenCursor
    dcm = datacursormode(Fig);
    dcm.UpdateFcn = @DataCursorEinst;

    %Achsen und Linien erzeugen
    %--------------------------
    Achsen_links = 0.15;
    Achse_unten = 0.1;
    Achsen_Hoehe = 0.35;
    Achsen_Breite = 0.75;
    Achsen_Abstand = 0.05;

    Achse_1 = axes;
    set(Achse_1,'Units','normalized',...
        'Position',[Achsen_links Achse_unten Achsen_Breite Achsen_Hoehe],...
        'Box','on','XGrid','on','YGrid','on','XLim',[min(Zeit) max(Zeit)]);
    set(get(Achse_1,'XLabel'),'String','Zeit [s]');
    set(get(Achse_1,'YLabel'),'String','Versorgungsspannung U [V]');
    
    set(zoom(Achse_1),'ActionPostCallback',@renew_Plots_zoom);

    Linie_U1 = line(Zeit,Spannung_Vers,'Parent',Achse_1,'Color','b');

    Achse_2 = axes;
    set(Achse_2,'Units','normalized',...
        'Position',[Achsen_links Achse_unten+Achsen_Hoehe+Achsen_Abstand Achsen_Breite Achsen_Hoehe],...
        'Box','on','XGrid','on','YGrid','on','XLim',[min(Zeit) max(Zeit)]);
    set(get(Achse_2,'YLabel'),'String','Kondensatorspannung U_C [V]');

    Linie_U2 = line(Zeit,Spannung_Kond,'Parent',Achse_2,'Color','r');
    
    linkaxes([Achse_1,Achse_2], 'x');
    
    %Zoom-Einstellungen
    Zoom_Handle = zoom(Fig);
    set(Zoom_Handle,'Enable','on');

    %UI-Objekt erzeugen
    %------------------
    edit_Hoehe = 0.03;
    edit_Breite = 0.08;
    push_x_Hoehe = 0.03;
    push_x_Breite = 0.14;
    push_y_Hoehe = 0.07;
    push_y_Breite = 0.08;
    
    UI_n_min = uicontrol('style','edit','Units','normalized',...
        'Position',[0.1 0.04 0.1 0.03],...
        'String',num2str(min(Zeit)),'callback',@set_x_Achse);
    UI_n_max = uicontrol('style','edit','Units','normalized',...
        'Position',[0.85 0.04 0.1 0.03],...
        'String',num2str(max(Zeit)),'callback',@set_x_Achse);
    UI_n_Reset = uicontrol('style','pushbutton',...
        'Units','normalized','Position',[0.83 0.01 0.14 0.03],...
        'String','Reset x-Achse','callback',@reset_x_Achse);
    
    akt_Achse = Achse_1;
    YLimits_U1 = get(akt_Achse,'YLim');
    Pos_unten = get(akt_Achse,'Position');
    Pos_unten = Pos_unten(2);
    UI_U1_max = uicontrol('style','edit','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten+(Achsen_Hoehe-edit_Hoehe) edit_Breite edit_Hoehe],...
        'String',num2str(YLimits_U1(2)),'callback',@set_y_Achse_U1);
    UI_U1_min = uicontrol('style','edit','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten edit_Breite edit_Hoehe],...
        'String',num2str(YLimits_U1(1)),'callback',@set_y_Achse_U1);
    UI_U1_Reset = uicontrol('style','pushbutton','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten+(Achsen_Hoehe/2-push_y_Hoehe/2) push_y_Breite push_y_Hoehe],...
        'String','Reset','callback',@reset_y_Achse_U1);
    
    akt_Achse = Achse_2;
    YLimits_U2 = get(akt_Achse,'YLim');
    Pos_unten = get(akt_Achse,'Position');
    Pos_unten = Pos_unten(2);
    UI_U2_max = uicontrol('style','edit','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten+(Achsen_Hoehe-edit_Hoehe) edit_Breite edit_Hoehe],...
        'String',num2str(YLimits_U2(2)),'callback',@set_y_Achse_U2);
    UI_U2_min = uicontrol('style','edit','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten edit_Breite edit_Hoehe],...
        'String',num2str(YLimits_U2(1)),'callback',@set_y_Achse_U2);
    UI_U2_Reset = uicontrol('style','pushbutton','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten+(Achsen_Hoehe/2-push_y_Hoehe/2) push_y_Breite push_y_Hoehe],...
        'String','Reset','callback',@reset_y_Achse_U2);
    
    akt_Achse = Achse_2;
    Pos_unten = get(akt_Achse,'Position');
    Achsen_Abstand = 0.01;
    Pos_unten = Pos_unten(2)+Pos_unten(4)+Achsen_Abstand;
    UI_MW_ber = uicontrol('style','pushbutton','Units','normalized',...
        'Position',[0.1 Pos_unten 0.2 0.05],...
        'String','Mittelwerte berechnen','callback',@calc_MW);
    UI_MW_Zaehler = uicontrol('style','text','Units','normalized',...
        'Position',[0.3 Pos_unten+0.06 0.2 0.02],'Visible','off',...
        'String','übertragene Werte: 0');  
    
    Pos_unten = Pos_unten - Achsen_Abstand;
    UI_U1_MW_text = uicontrol('style','text','Units','normalized',...
        'Position',[0.6 Pos_unten 0.25 (1-Pos_unten)/3*0.9],...
        'HorizontalAlignment','left','String','Versorgungsspannung [V]','Visible','off');
    UI_U2_MW_text = uicontrol('style','text','Units','normalized',...
        'Position',[0.6 Pos_unten+(1-Pos_unten)/3 0.25 (1-Pos_unten)/3*0.9],...
        'HorizontalAlignment','left','String','Kondensatorspannung [V]','Visible','off');
    UI_U1_MW_wert = uicontrol('style','text','Units','normalized',...
        'Position',[0.85 Pos_unten 0.1 (1-Pos_unten)/3*0.9],...
        'String','0','FontWeight','bold','Visible','off');
    UI_U2_MW_wert = uicontrol('style','text','Units','normalized',...
        'Position',[0.85 Pos_unten+(1-Pos_unten)/3 0.1 (1-Pos_unten)/3*0.9],...
        'String','0','FontWeight','bold','Visible','off');
    
    %UI callback-Functions
    %---------------------
    function set_x_Achse(source,callbackdata)
        x_min = str2num(get(UI_n_min,'String'));
        x_max = str2num(get(UI_n_max,'String'));
        
        if x_min > x_max
            temp = x_min;
            x_min = x_max;
            x_max = temp;
            set(UI_n_min,'String',num2str(x_min));
            set(UI_n_max,'String',num2str(x_max));
        elseif x_max == x_min
            x_max = x_min+Zeit(2)-Zeit(1);
            set(UI_n_min,'String',num2str(x_min));
            set(UI_n_max,'String',num2str(x_max));
        end
        set(Achse_1,'XLim',[x_min x_max]);
        set(Achse_2,'XLim',[x_min x_max]);
        
        %neue Y-Limits der Plots auslesen und setzen
        YLimits_U1_temp = get(Achse_1,'YLim');
        set(UI_U1_min,'String',num2str(YLimits_U1_temp(1)));
        set(UI_U1_max,'String',num2str(YLimits_U1_temp(2)));
        
        YLimits_U2_temp = get(Achse_2,'YLim');
        set(UI_U2_min,'String',num2str(YLimits_U2_temp(1)));
        set(UI_U2_max,'String',num2str(YLimits_U2_temp(2)));
        
    end

    function reset_x_Achse(source,callbackdata)
        x_min = Zeit(1);
        x_max = Zeit(end);
        
        set(UI_n_min,'String',num2str(x_min));
        set(UI_n_max,'String',num2str(x_max));
        
        set(Achse_1,'XLim',[x_min x_max]);
        set(Achse_2,'XLim',[x_min x_max]);
    end

    function set_y_Achse_U1(source,callbackdata)
        y_min = str2num(get(UI_U1_min,'String'));
        y_max = str2num(get(UI_U1_max,'String'));
        
        if y_min > y_max
            temp = y_min;
            y_min = y_max;
            y_max = temp;
            set(UI_U1_min,'String',num2str(y_min));
            set(UI_U1_max,'String',num2str(y_max));
        elseif y_max == y_min
            y_max = y_min+0.1;
            set(UI_U1_min,'String',num2str(y_min));
            set(UI_U1_max,'String',num2str(y_max));
        end
        set(Achse_1,'YLim',[y_min y_max]);
    end

    function reset_y_Achse_U1(source,callbackdata)
        y_min = YLimits_U1(1);
        y_max = YLimits_U1(2);
        
        set(UI_U1_min,'String',num2str(y_min));
        set(UI_U1_max,'String',num2str(y_max));
        
        set(Achse_1,'YLim',[y_min y_max]);
    end

    function set_y_Achse_U2(source,callbackdata)
        y_min = str2num(get(UI_U2_min,'String'));
        y_max = str2num(get(UI_U2_max,'String'));
        
        if y_min > y_max
            temp = y_min;
            y_min = y_max;
            y_max = temp;
            set(UI_U2_min,'String',num2str(y_min));
            set(UI_U2_max,'String',num2str(y_max));
        elseif y_max == y_min
            y_max = y_min+0.1;
            set(UI_U2_min,'String',num2str(y_min));
            set(UI_U2_max,'String',num2str(y_max));
        end
        set(Achse_2,'YLim',[y_min y_max]);
    end

    function reset_y_Achse_U2(source,callbackdata)
        y_min = YLimits_U2(1);
        y_max = YLimits_U2(2);
        
        set(UI_U2_min,'String',num2str(y_min));
        set(UI_U2_max,'String',num2str(y_max));
        
        set(Achse_2,'YLim',[y_min y_max]);
    end

    function calc_MW(source,callbackdata)
        Zeitbereich = get(Achse_1,'XLim');
        Zeit_min_MW = Zeitbereich(1);
        Zeit_max_MW = Zeitbereich(2);
        
        Index_min_MW = find(Zeit>=Zeit_min_MW,1);
        if isempty(Index_min_MW)
            Index_min_MW = 1;
        end
        
        Index_max_MW = find(Zeit>=Zeit_max_MW,1);
        if isempty(Index_max_MW)
            Index_max_MW = length(Zeit);
        end
        
        MW_U = mean(Spannung_Vers(Index_min_MW:Index_max_MW));
        MW_i = mean(Spannung_Kond(Index_min_MW:Index_max_MW));
        R_A = MW_U/MW_i;
        
        clear Zeitbereich Zeit_min_MW Zeit_max_MW Index_min_MW Index_max_MW
        
        set(UI_U1_MW_text,'Visible','on')
        set(UI_U2_MW_text,'Visible','on')
        set(UI_U1_MW_wert,'String',num2str(MW_U,'%6.3f'),'Visible','on')
        set(UI_U2_MW_wert,'String',num2str(MW_i,'%6.3f'),'Visible','on')
        
    end

    function renew_Plots_zoom(source,callbackdata)
        %x-Werte in UIs übernehmen
        X_Limits_zoom = get(Achse_1,'XLim');
        set(UI_n_min,'String',num2str(X_Limits_zoom(1),'%6.3f'));
        set(UI_n_max,'String',num2str(X_Limits_zoom(2),'%6.3f'));
        clear X_Limits_zoom
        
        %y-Werte in UIs Achse_1 übernehmen
        Y_Limits_zoom = get(Achse_1,'YLim');
        set(UI_U1_min,'String',num2str(Y_Limits_zoom(1),'%6.3f'));
        set(UI_U1_max,'String',num2str(Y_Limits_zoom(2),'%6.3f'));
        clear Y_Limits_zoom
        
        %y-Werte in UIs Achse_2 übernehmen
        Y_Limits_zoom = get(Achse_2,'YLim');
        set(UI_U2_min,'String',num2str(Y_Limits_zoom(1),'%6.3f'));
        set(UI_U2_max,'String',num2str(Y_Limits_zoom(2),'%6.3f'));
        clear Y_Limits_zoom
    end

    uiwait(Fig)
        
end