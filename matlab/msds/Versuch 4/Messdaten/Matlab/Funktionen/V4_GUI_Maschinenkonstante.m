function V4_GUI_Maschinenkonstante(Zeit,U_B,PWM_EM,i_A,v_rot,Infos)

    %Parameter
    %---------
    r_ZR = 20.93e-3*1.004;

    %Spannung und Winkelgeschwindigkeit berechnen
    %--------------------------------------------
    Mittelung_omega = 5;
    U_A = U_B.*PWM_EM/100;
    omega_EM = v_rot./r_ZR;
    omega_EM = movmean(omega_EM,Mittelung_omega);

    %Figure erzeugen
    %---------------
    Fig = figure;
    c_Fig = 0.95;
    set(Fig,'Color',[c_Fig c_Fig c_Fig],'Units','normalized','Position',[0.3 0.1 0.45 0.8]);
    set(Fig,'Name',Infos.fileName)
    clear c_Fig

    %Achsen und Linien erzeugen
    %--------------------------
    Achsen_links = 0.15;
    Achse_unten = 0.1;
    Achsen_Hoehe = 0.23;
    Achsen_Breite = 0.75;
    Achsen_Abstand = 0.05;

    Achse_1 = axes;
    set(Achse_1,'Units','normalized',...
        'Position',[Achsen_links Achse_unten Achsen_Breite Achsen_Hoehe],...
        'Box','on','XGrid','on','YGrid','on','XLim',[min(Zeit) max(Zeit)]);
    set(get(Achse_1,'XLabel'),'String','Zeit [s]');
    set(get(Achse_1,'YLabel'),'String','Ankerspannung U_A [V]');
    
    set(zoom(Achse_1),'ActionPostCallback',@renew_Plots_zoom);

    Linie_UA = line(Zeit,U_A,'Parent',Achse_1,'Color','b');

    Achse_2 = axes;
    set(Achse_2,'Units','normalized',...
        'Position',[Achsen_links Achse_unten+Achsen_Hoehe+Achsen_Abstand Achsen_Breite Achsen_Hoehe],...
        'Box','on','XGrid','on','YGrid','on','XLim',[min(Zeit) max(Zeit)]);
    set(get(Achse_2,'YLabel'),'String','Ankerstrom i_A [A]');

    Linie_iA = line(Zeit,i_A,'Parent',Achse_2,'Color','r');

    Achse_3 = axes;
    set(Achse_3,'Units','normalized',...
        'Position',[Achsen_links Achse_unten+2*(Achsen_Hoehe+Achsen_Abstand) Achsen_Breite Achsen_Hoehe],...
        'Box','on','XGrid','on','YGrid','on','XLim',[min(Zeit) max(Zeit)]);
    set(get(Achse_3,'YLabel'),'String','Winkelgeschwindigkeit \omega_{EM} [rad/s]');

    Linie_nM = line(Zeit,omega_EM,'Parent',Achse_3,'Color',[0 0.5 0]);
    
    linkaxes([Achse_1,Achse_2,Achse_3], 'x');
    
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
    
    UI_x_min = uicontrol('style','edit','Units','normalized',...
        'Position',[0.1 0.04 0.1 0.03],...
        'String',num2str(min(Zeit)),'callback',@set_x_Achse);
    UI_x_max = uicontrol('style','edit','Units','normalized',...
        'Position',[0.85 0.04 0.1 0.03],...
        'String',num2str(max(Zeit)),'callback',@set_x_Achse);
    UI_x_Reset = uicontrol('style','pushbutton',...
        'Units','normalized','Position',[0.83 0.01 0.14 0.03],...
        'String','Reset x-Achse','callback',@reset_x_Achse);
    
    akt_Achse = Achse_1;
    YLimits_UA = get(akt_Achse,'YLim');
    Pos_unten = get(akt_Achse,'Position');
    Pos_unten = Pos_unten(2);
    UI_UA_max = uicontrol('style','edit','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten+(Achsen_Hoehe-edit_Hoehe) edit_Breite edit_Hoehe],...
        'String',num2str(YLimits_UA(2)),'callback',@set_y_Achse_UA);
    UI_UA_min = uicontrol('style','edit','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten edit_Breite edit_Hoehe],...
        'String',num2str(YLimits_UA(1)),'callback',@set_y_Achse_UA);
    UI_UA_Reset = uicontrol('style','pushbutton','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten+(Achsen_Hoehe/2-push_y_Hoehe/2) push_y_Breite push_y_Hoehe],...
        'String','Reset','callback',@reset_y_Achse_UA);
    
    akt_Achse = Achse_2;
    YLimits_iA = get(akt_Achse,'YLim');
    Pos_unten = get(akt_Achse,'Position');
    Pos_unten = Pos_unten(2);
    UI_iA_max = uicontrol('style','edit','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten+(Achsen_Hoehe-edit_Hoehe) edit_Breite edit_Hoehe],...
        'String',num2str(YLimits_iA(2)),'callback',@set_y_Achse_iA);
    UI_iA_min = uicontrol('style','edit','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten edit_Breite edit_Hoehe],...
        'String',num2str(YLimits_iA(1)),'callback',@set_y_Achse_iA);
    UI_iA_Reset = uicontrol('style','pushbutton','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten+(Achsen_Hoehe/2-push_y_Hoehe/2) push_y_Breite push_y_Hoehe],...
        'String','Reset','callback',@reset_y_Achse_iA);
    
    akt_Achse = Achse_3;
    YLimits_omega = get(akt_Achse,'YLim');
    Pos_unten = get(akt_Achse,'Position');
    Pos_unten = Pos_unten(2);
    UI_omega_max = uicontrol('style','edit','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten+(Achsen_Hoehe-edit_Hoehe) edit_Breite edit_Hoehe],...
        'String',num2str(YLimits_omega(2)),'callback',@set_y_Achse_omega);
    UI_omega_min = uicontrol('style','edit','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten edit_Breite edit_Hoehe],...
        'String',num2str(YLimits_omega(1)),'callback',@set_y_Achse_omega);
    UI_omega_Reset = uicontrol('style','pushbutton','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten+(Achsen_Hoehe/2-push_y_Hoehe/2) push_y_Breite push_y_Hoehe],...
        'String','Reset','callback',@reset_y_Achse_omega);
    
    akt_Achse = Achse_3;
    Pos_unten = get(akt_Achse,'Position');
    Pos_unten = Pos_unten(2)+Pos_unten(4)+Achsen_Abstand;
    UI_MW_ber = uicontrol('style','pushbutton','Units','normalized',...
        'Position',[0.1 Pos_unten 0.2 0.05],...
        'String','Mittelwerte berechnen','callback',@calc_MW);
    Pos_unten = Pos_unten - Achsen_Abstand;
    UI_UA_MW_text = uicontrol('style','text','Units','normalized',...
        'Position',[0.65 Pos_unten 0.2 (1-Pos_unten)/3*0.9],...
        'HorizontalAlignment','left','String','Mittelwert U_A [V]','Visible','off');
    UI_iA_MW_text = uicontrol('style','text','Units','normalized',...
        'Position',[0.65 Pos_unten+(1-Pos_unten)/3 0.2 (1-Pos_unten)/3*0.9],...
        'HorizontalAlignment','left','String','Mittelwert i_A [A]','Visible','off');
    UI_omega_MW_text = uicontrol('style','text','Units','normalized',...
        'Position',[0.65 Pos_unten+(1-Pos_unten)*2/3 0.2 (1-Pos_unten)/3*0.9],...
        'HorizontalAlignment','left','String','Mittelwert omega_EM [rad/s]','Visible','off');
    UI_UA_MW_wert = uicontrol('style','text','Units','normalized',...
        'Position',[0.85 Pos_unten 0.1 (1-Pos_unten)/3*0.9],...
        'String','0','FontWeight','bold','Visible','off');
    UI_iA_MW_wert = uicontrol('style','text','Units','normalized',...
        'Position',[0.85 Pos_unten+(1-Pos_unten)/3 0.1 (1-Pos_unten)/3*0.9],...
        'String','0','FontWeight','bold','Visible','off');
    UI_omega_MW_wert = uicontrol('style','text','Units','normalized',...
        'Position',[0.85 Pos_unten+(1-Pos_unten)*2/3 0.1 (1-Pos_unten)/3*0.9],...
        'String','0','FontWeight','bold','Visible','off');
    
    %UI callback-Functions
    %---------------------
    function set_x_Achse(source,callbackdata)
        x_min = str2num(get(UI_x_min,'String'));
        x_max = str2num(get(UI_x_max,'String'));
        
        if x_min > x_max
            temp = x_min;
            x_min = x_max;
            x_max = temp;
            set(UI_x_min,'String',num2str(x_min));
            set(UI_x_max,'String',num2str(x_max));
        elseif x_max == x_min
            x_max = x_min+Zeit(2)-Zeit(1);
            set(UI_x_min,'String',num2str(x_min));
            set(UI_x_max,'String',num2str(x_max));
        end
        set(Achse_1,'XLim',[x_min x_max]);
        set(Achse_2,'XLim',[x_min x_max]);
        set(Achse_3,'XLim',[x_min x_max]);
        
        %neue Y-Limits der Plots auslesen und setzen
        YLimits_UB_temp = get(Achse_1,'YLim');
        set(UI_UA_min,'String',num2str(YLimits_UB_temp(1)));
        set(UI_UA_max,'String',num2str(YLimits_UB_temp(2)));
        
        YLimits_iA_temp = get(Achse_2,'YLim');
        set(UI_iA_min,'String',num2str(YLimits_iA_temp(1)));
        set(UI_iA_max,'String',num2str(YLimits_iA_temp(2)));
        
        YLimits_nM_temp = get(Achse_3,'YLim');
        set(UI_omega_min,'String',num2str(YLimits_nM_temp(1)));
        set(UI_omega_max,'String',num2str(YLimits_nM_temp(2)));
    end

    function reset_x_Achse(source,callbackdata)
        x_min = Zeit(1);
        x_max = Zeit(end);
        
        set(UI_x_min,'String',num2str(x_min));
        set(UI_x_max,'String',num2str(x_max));
        
        set(Achse_1,'XLim',[x_min x_max]);
        set(Achse_2,'XLim',[x_min x_max]);
        set(Achse_3,'XLim',[x_min x_max]);
    end

    function set_y_Achse_UA(source,callbackdata)
        y_min = str2num(get(UI_UA_min,'String'));
        y_max = str2num(get(UI_UA_max,'String'));
        
        if y_min > y_max
            temp = y_min;
            y_min = y_max;
            y_max = temp;
            set(UI_UA_min,'String',num2str(y_min));
            set(UI_UA_max,'String',num2str(y_max));
        elseif y_max == y_min
            y_max = y_min+0.1;
            set(UI_UA_min,'String',num2str(y_min));
            set(UI_UA_max,'String',num2str(y_max));
        end
        set(Achse_1,'YLim',[y_min y_max]);
    end

    function reset_y_Achse_UA(source,callbackdata)
        %y-Achse
        y_min = YLimits_UA(1);
        y_max = YLimits_UA(2);
        
        set(UI_UA_min,'String',num2str(y_min));
        set(UI_UA_max,'String',num2str(y_max));
        
        set(Achse_1,'YLim',[y_min y_max]);
        
        %x-Achse
        x_min = Zeit(1);
        x_max = Zeit(end);
        
        set(UI_x_min,'String',num2str(x_min));
        set(UI_x_max,'String',num2str(x_max));
        
        set(Achse_1,'XLim',[x_min x_max]);
        set(Achse_2,'XLim',[x_min x_max]);
        set(Achse_3,'XLim',[x_min x_max]);
    end

    function set_y_Achse_iA(source,callbackdata)
        y_min = str2num(get(UI_iA_min,'String'));
        y_max = str2num(get(UI_iA_max,'String'));
        
        if y_min > y_max
            temp = y_min;
            y_min = y_max;
            y_max = temp;
            set(UI_iA_min,'String',num2str(y_min));
            set(UI_iA_max,'String',num2str(y_max));
        elseif y_max == y_min
            y_max = y_min+0.1;
            set(UI_iA_min,'String',num2str(y_min));
            set(UI_iA_max,'String',num2str(y_max));
        end
        set(Achse_2,'YLim',[y_min y_max]);
    end

    function reset_y_Achse_iA(source,callbackdata)
        %y-Achse
        y_min = YLimits_iA(1);
        y_max = YLimits_iA(2);
        
        set(UI_iA_min,'String',num2str(y_min));
        set(UI_iA_max,'String',num2str(y_max));
        
        set(Achse_2,'YLim',[y_min y_max]);
        
        %x-Achse
        x_min = Zeit(1);
        x_max = Zeit(end);
        
        set(UI_x_min,'String',num2str(x_min));
        set(UI_x_max,'String',num2str(x_max));
        
        set(Achse_1,'XLim',[x_min x_max]);
        set(Achse_2,'XLim',[x_min x_max]);
        set(Achse_3,'XLim',[x_min x_max]);
    end

    function set_y_Achse_omega(source,callbackdata)
        y_min = str2num(get(UI_omega_min,'String'));
        y_max = str2num(get(UI_omega_max,'String'));
        
        if y_min > y_max
            temp = y_min;
            y_min = y_max;
            y_max = temp;
            set(UI_omega_min,'String',num2str(y_min));
            set(UI_omega_max,'String',num2str(y_max));
        elseif y_max == y_min
            y_max = y_min+0.1;
            set(UI_omega_min,'String',num2str(y_min));
            set(UI_omega_max,'String',num2str(y_max));
        end
        set(Achse_3,'YLim',[y_min y_max]);
    end

    function reset_y_Achse_omega(source,callbackdata)
        %y-Achse
        y_min = YLimits_omega(1);
        y_max = YLimits_omega(2);
        
        set(UI_omega_min,'String',num2str(y_min));
        set(UI_omega_max,'String',num2str(y_max));
        
        set(Achse_3,'YLim',[y_min y_max]);
        
        %x-Achse
        x_min = Zeit(1);
        x_max = Zeit(end);
        
        set(UI_x_min,'String',num2str(x_min));
        set(UI_x_max,'String',num2str(x_max));
        
        set(Achse_1,'XLim',[x_min x_max]);
        set(Achse_2,'XLim',[x_min x_max]);
        set(Achse_3,'XLim',[x_min x_max]);
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
        
        MW_UB = mean(U_A(Index_min_MW:Index_max_MW));
        MW_iA = mean(i_A(Index_min_MW:Index_max_MW));
        MW_nM = mean(omega_EM(Index_min_MW:Index_max_MW));
        
        clear Zeitbereich Zeit_min_MW Zeit_max_MW Index_min_MW Index_max_MW
        
        set(UI_UA_MW_text,'Visible','on')
        set(UI_iA_MW_text,'Visible','on')
        set(UI_omega_MW_text,'Visible','on')
        set(UI_UA_MW_wert,'String',num2str(MW_UB,'%6.3f'),'Visible','on')
        set(UI_iA_MW_wert,'String',num2str(MW_iA,'%6.3f'),'Visible','on')
        set(UI_omega_MW_wert,'String',num2str(MW_nM,'%6.3f'),'Visible','on')
    end

    function renew_Plots_zoom(source,callbackdata)
        %x-Werte in UIs übernehmen
        X_Limits_zoom = get(Achse_1,'XLim');
        set(UI_x_min,'String',num2str(X_Limits_zoom(1),'%6.3f'));
        set(UI_x_max,'String',num2str(X_Limits_zoom(2),'%6.3f'));
        clear X_Limits_zoom
        
        %y-Werte in UIs Achse_1 übernehmen
        Y_Limits_zoom = get(Achse_1,'YLim');
        set(UI_UA_min,'String',num2str(Y_Limits_zoom(1),'%6.3f'));
        set(UI_UA_max,'String',num2str(Y_Limits_zoom(2),'%6.3f'));
        clear Y_Limits_zoom
        
        %y-Werte in UIs Achse_2 übernehmen
        Y_Limits_zoom = get(Achse_2,'YLim');
        set(UI_iA_min,'String',num2str(Y_Limits_zoom(1),'%6.3f'));
        set(UI_iA_max,'String',num2str(Y_Limits_zoom(2),'%6.3f'));
        clear Y_Limits_zoom
        
        %y-Werte in UIs Achse_3 übernehmen
        Y_Limits_zoom = get(Achse_3,'YLim');
        set(UI_omega_min,'String',num2str(Y_Limits_zoom(1),'%6.3f'));
        set(UI_omega_max,'String',num2str(Y_Limits_zoom(2),'%6.3f'));
        clear Y_Limits_zoom
    end

    uiwait(Fig)
        
end