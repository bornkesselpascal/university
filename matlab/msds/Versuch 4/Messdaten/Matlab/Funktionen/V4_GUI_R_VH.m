function V4_GUI_R_VH(Zeit,U_B,i_A,v_rot,PWM_EM,Infos)

    % Parameter
    k_M = 42.43e-3; % Maschinenkonstante Vs/rad
    r_ZR = 20.93e-3*1.004;
    R_A = 0.36; %
    U_V_Switch = 0;
    
    % Extraktion des Messbereichs zu dem die EM angesteuert wird
    Indizes = find(PWM_EM > 0);
    Indizes = Indizes(2:end);
    Zeit = Zeit(Indizes);
    U_B = U_B(Indizes);
    i_A = i_A(Indizes);
    v_rot = v_rot(Indizes);
    PWM_EM = PWM_EM(Indizes);
    
    % Berechnung Ankerspannung
    omega = v_rot/r_ZR;
    U_A = (U_B-2*U_V_Switch).*PWM_EM/100 + k_M * omega;
    
    % Berechnung des ANkerwiderstands
    R_VH = U_A./i_A - R_A;

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
    Achsen_Hoehe = 0.24;
    Achsen_Breite = 0.75;
    Achsen_Abstand = 0.05;

    Achse_1 = axes;
    set(Achse_1,'Units','normalized',...
        'Position',[Achsen_links Achse_unten Achsen_Breite Achsen_Hoehe],...
        'Box','on','XGrid','on','YGrid','on','XLim',[min(Zeit) max(Zeit)]);
    set(get(Achse_1,'XLabel'),'String','Zeit [s]');
    set(get(Achse_1,'YLabel'),'String','Spannung über dem Anker [V]');
    
    set(zoom(Achse_1),'ActionPostCallback',@renew_Plots_zoom);

    Linie_U_A = line(Zeit,U_A,'Parent',Achse_1,'Color','b');
    
    Achse_2 = axes;
    set(Achse_2,'Units','normalized',...
        'Position',[Achsen_links Achse_unten+Achsen_Hoehe+Achsen_Abstand Achsen_Breite Achsen_Hoehe],...
        'Box','on','XGrid','on','YGrid','on','XLim',[min(Zeit) max(Zeit)]);
    set(get(Achse_2,'YLabel'),'String','Ankerstrom [A]');
    
    set(zoom(Achse_2),'ActionPostCallback',@renew_Plots_zoom);

    Linie_i_A = line(Zeit,i_A,'Parent',Achse_2,'Color',[0 0.5 0]);
    
    
    Achse_3 = axes;
    set(Achse_3,'Units','normalized',...
        'Position',[Achsen_links Achse_unten+2*Achsen_Hoehe+2*Achsen_Abstand Achsen_Breite Achsen_Hoehe],...
        'Box','on','XGrid','on','YGrid','on','XLim',[min(Zeit) max(Zeit)]);
    set(get(Achse_3,'YLabel'),'String','Verlustwiderstand H-Brücke [Ohm]');

    Linie_R_VH = line(Zeit,R_VH,'Parent',Achse_3,'Color','r');
    
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
    
    UI_Zeit_min = uicontrol('style','edit','Units','normalized',...
        'Position',[0.1 0.04 0.1 0.03],...
        'String',num2str(min(Zeit)),'callback',@set_x_Achse);
    UI_Zeit_max = uicontrol('style','edit','Units','normalized',...
        'Position',[0.85 0.04 0.1 0.03],...
        'String',num2str(max(Zeit)),'callback',@set_x_Achse);
    UI_Zeit_Reset = uicontrol('style','pushbutton',...
        'Units','normalized','Position',[0.83 0.01 0.14 0.03],...
        'String','Reset x-Achse','callback',@reset_x_Achse);
    
    akt_Achse = Achse_1;
    YLimits_U_A = get(akt_Achse,'YLim');
    Pos_unten = get(akt_Achse,'Position');
    Pos_unten = Pos_unten(2);
    UI_U_A_max = uicontrol('style','edit','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten+(Achsen_Hoehe-edit_Hoehe) edit_Breite edit_Hoehe],...
        'String',num2str(YLimits_U_A(2)),'callback',@set_y_Achse_U_A);
    UI_U_A_min = uicontrol('style','edit','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten edit_Breite edit_Hoehe],...
        'String',num2str(YLimits_U_A(1)),'callback',@set_y_Achse_U_A);
    UI_U_A_Reset = uicontrol('style','pushbutton','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten+(Achsen_Hoehe/2-push_y_Hoehe/2) push_y_Breite push_y_Hoehe],...
        'String','Reset','callback',@reset_y_Achse_U_A);
    
    akt_Achse = Achse_2;
    YLimits_i_A = get(akt_Achse,'YLim');
    Pos_unten = get(akt_Achse,'Position');
    Pos_unten = Pos_unten(2);
    UI_i_A_max = uicontrol('style','edit','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten+(Achsen_Hoehe-edit_Hoehe) edit_Breite edit_Hoehe],...
        'String',num2str(YLimits_i_A(2)),'callback',@set_y_Achse_i_A);
    UI_i_A_min = uicontrol('style','edit','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten edit_Breite edit_Hoehe],...
        'String',num2str(YLimits_i_A(1)),'callback',@set_y_Achse_i_A);
    UI_i_A_Reset = uicontrol('style','pushbutton','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten+(Achsen_Hoehe/2-push_y_Hoehe/2) push_y_Breite push_y_Hoehe],...
        'String','Reset','callback',@reset_y_Achse_i_A);
    
    akt_Achse = Achse_3;
    YLimits_R_VH = get(akt_Achse,'YLim');
    Pos_unten = get(akt_Achse,'Position');
    Pos_unten = Pos_unten(2);
    UI_R_VH_max = uicontrol('style','edit','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten+(Achsen_Hoehe-edit_Hoehe) edit_Breite edit_Hoehe],...
        'String',num2str(YLimits_R_VH(2)),'callback',@set_y_Achse_R_VH);
    UI_R_VH_min = uicontrol('style','edit','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten edit_Breite edit_Hoehe],...
        'String',num2str(YLimits_R_VH(1)),'callback',@set_y_Achse_R_VH);
    UI_R_VH_Reset = uicontrol('style','pushbutton','Units','normalized',...
        'Position',[Achsen_links+Achsen_Breite+0.01 Pos_unten+(Achsen_Hoehe/2-push_y_Hoehe/2) push_y_Breite push_y_Hoehe],...
        'String','Reset','callback',@reset_y_Achse_R_VH);
    
    akt_Achse = Achse_3;
    Pos_unten = get(akt_Achse,'Position');
    Achsen_Abstand = 0.01;
    Pos_unten = Pos_unten(2)+Pos_unten(4)+Achsen_Abstand;
    UI_MW_ber = uicontrol('style','pushbutton','Units','normalized',...
        'Position',[0.1 Pos_unten 0.2 0.05],...
        'String','Mittelwerte berechnen','callback',@calc_MW);  
    
    Pos_unten = Pos_unten - Achsen_Abstand;
    UI_U_A_MW_text = uicontrol('style','text','Units','normalized',...
        'Position',[0.6 Pos_unten 0.25 (1-Pos_unten)/3*0.9],...
        'HorizontalAlignment','left','String','Mittelwert U_A [V]','Visible','off');
    UI_i_A_MW_text = uicontrol('style','text','Units','normalized',...
        'Position',[0.6 Pos_unten+(1-Pos_unten)/3 0.25 (1-Pos_unten)/3*0.9],...
        'HorizontalAlignment','left','String','Mittelwert i_A [A]','Visible','off');
    UI_R_VH_MW_text = uicontrol('style','text','Units','normalized',...
        'Position',[0.6 Pos_unten+(1-Pos_unten)*2/3 0.25 (1-Pos_unten)/3*0.9],...
        'HorizontalAlignment','left','String','Mittelwert R_VH [Ohm]','Visible','off');
    UI_U_A_MW_wert = uicontrol('style','text','Units','normalized',...
        'Position',[0.85 Pos_unten 0.1 (1-Pos_unten)/3*0.9],...
        'String','0','FontWeight','bold','Visible','off');
    UI_i_A_MW_wert = uicontrol('style','text','Units','normalized',...
        'Position',[0.85 Pos_unten+(1-Pos_unten)/3 0.1 (1-Pos_unten)/3*0.9],...
        'String','0','FontWeight','bold','Visible','off');
    UI_R_VH_MW_wert = uicontrol('style','text','Units','normalized',...
        'Position',[0.85 Pos_unten+(1-Pos_unten)*2/3 0.1 (1-Pos_unten)/3*0.9],...
        'String','0','FontWeight','bold','Visible','off');
    
    %UI callback-Functions
    %---------------------
    function set_x_Achse(source,callbackdata)
        x_min = str2num(get(UI_Zeit_min,'String'));
        x_max = str2num(get(UI_Zeit_max,'String'));
        
        if x_min > x_max
            temp = x_min;
            x_min = x_max;
            x_max = temp;
            set(UI_Zeit_min,'String',num2str(x_min));
            set(UI_Zeit_max,'String',num2str(x_max));
        elseif x_max == x_min
            x_max = x_min+Zeit(2)-Zeit(1);
            set(UI_Zeit_min,'String',num2str(x_min));
            set(UI_Zeit_max,'String',num2str(x_max));
        end
        set(Achse_1,'XLim',[x_min x_max]);
        set(Achse_2,'XLim',[x_min x_max]);
        set(Achse_3,'XLim',[x_min x_max]);
        
        %neue Y-Limits der Plots auslesen und setzen
        YLimits_Ua_temp = get(Achse_1,'YLim');
        set(UI_U_A_min,'String',num2str(YLimits_Ua_temp(1)));
        set(UI_U_A_max,'String',num2str(YLimits_Ua_temp(2)));
        
        YLimits_Ia_temp = get(Achse_2,'YLim');
        set(UI_i_A_min,'String',num2str(YLimits_Ia_temp(1)));
        set(UI_i_A_max,'String',num2str(YLimits_Ia_temp(2)));
        
        YLimits_RLast_temp = get(Achse_3,'YLim');
        set(UI_i_A_min,'String',num2str(YLimits_RLast_temp(1)));
        set(UI_i_A_max,'String',num2str(YLimits_RLast_temp(2)));
        
    end

    function reset_x_Achse(source,callbackdata)
        x_min = Zeit(1);
        x_max = Zeit(end);
        
        set(UI_Zeit_min,'String',num2str(x_min));
        set(UI_Zeit_max,'String',num2str(x_max));
        
        set(Achse_1,'XLim',[x_min x_max]);
        set(Achse_2,'XLim',[x_min x_max]);
        set(Achse_3,'XLim',[x_min x_max]);
    end

    function set_y_Achse_U_A(source,callbackdata)
        y_min = str2num(get(UI_U_A_min,'String'));
        y_max = str2num(get(UI_U_A_max,'String'));
        
        if y_min > y_max
            temp = y_min;
            y_min = y_max;
            y_max = temp;
            set(UI_U_A_min,'String',num2str(y_min));
            set(UI_U_A_max,'String',num2str(y_max));
        elseif y_max == y_min
            y_max = y_min+0.1;
            set(UI_U_A_min,'String',num2str(y_min));
            set(UI_U_A_max,'String',num2str(y_max));
        end
        set(Achse_1,'YLim',[y_min y_max]);
    end

    function reset_y_Achse_U_A(source,callbackdata)
        %y-Achse
        y_min = YLimits_U_A(1);
        y_max = YLimits_U_A(2);
        
        set(UI_U_A_min,'String',num2str(y_min));
        set(UI_U_A_max,'String',num2str(y_max));
        
        set(Achse_1,'YLim',[y_min y_max]);
        
        %x-Achse
        x_min = Zeit(1);
        x_max = Zeit(end);
        
        set(UI_Zeit_min,'String',num2str(x_min));
        set(UI_Zeit_max,'String',num2str(x_max));
        
        set(Achse_1,'XLim',[x_min x_max]);
        set(Achse_2,'XLim',[x_min x_max]);
        set(Achse_3,'XLim',[x_min x_max]);
    end

    function set_y_Achse_i_A(source,callbackdata)
        y_min = str2num(get(UI_i_A_min,'String'));
        y_max = str2num(get(UI_i_A_max,'String'));
        
        if y_min > y_max
            temp = y_min;
            y_min = y_max;
            y_max = temp;
            set(UI_i_A_min,'String',num2str(y_min));
            set(UI_i_A_max,'String',num2str(y_max));
        elseif y_max == y_min
            y_max = y_min+0.1;
            set(UI_i_A_min,'String',num2str(y_min));
            set(UI_i_A_max,'String',num2str(y_max));
        end
        set(Achse_2,'YLim',[y_min y_max]);
    end

    function reset_y_Achse_i_A(source,callbackdata)
        %y-Achse
        y_min = YLimits_i_A(1);
        y_max = YLimits_i_A(2);
        
        set(UI_i_A_min,'String',num2str(y_min));
        set(UI_i_A_max,'String',num2str(y_max));
        
        set(Achse_2,'YLim',[y_min y_max]);
        
        %x-Achse
        x_min = Zeit(1);
        x_max = Zeit(end);
        
        set(UI_Zeit_min,'String',num2str(x_min));
        set(UI_Zeit_max,'String',num2str(x_max));
        
        set(Achse_1,'XLim',[x_min x_max]);
        set(Achse_2,'XLim',[x_min x_max]);
        set(Achse_3,'XLim',[x_min x_max]);
    end

    function set_y_Achse_R_VH(source,callbackdata)
        y_min = str2num(get(UI_R_VH_min,'String'));
        y_max = str2num(get(UI_R_VH_max,'String'));
        
        if y_min > y_max
            temp = y_min;
            y_min = y_max;
            y_max = temp;
            set(UI_R_VH_min,'String',num2str(y_min));
            set(UI_R_VH_max,'String',num2str(y_max));
        elseif y_max == y_min
            y_max = y_min+0.1;
            set(UI_R_VH_min,'String',num2str(y_min));
            set(UI_R_VH_max,'String',num2str(y_max));
        end
        set(Achse_3,'YLim',[y_min y_max]);
    end

    function reset_y_Achse_R_VH(source,callbackdata)
        %y-Achse
        y_min = YLimits_R_VH(1);
        y_max = YLimits_R_VH(2);
        
        set(UI_R_VH_min,'String',num2str(y_min));
        set(UI_R_VH_max,'String',num2str(y_max));
        
        set(Achse_3,'YLim',[y_min y_max]);
        
        %x-Achse
        x_min = Zeit(1);
        x_max = Zeit(end);
        
        set(UI_Zeit_min,'String',num2str(x_min));
        set(UI_Zeit_max,'String',num2str(x_max));
        
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
        
        MW_U_A = mean(U_A(Index_min_MW:Index_max_MW));
        MW_i_A = mean(i_A(Index_min_MW:Index_max_MW));
        MW_R_VH = mean(R_VH(Index_min_MW:Index_max_MW));
        R_VH_MW = MW_U_A/MW_i_A;
        
        clear Zeitbereich Zeit_min_MW Zeit_max_MW Index_min_MW Index_max_MW
        
        set(UI_U_A_MW_text,'Visible','on')
        set(UI_i_A_MW_text,'Visible','on')
        set(UI_R_VH_MW_text,'Visible','on')
        set(UI_U_A_MW_wert,'String',num2str(MW_U_A,'%6.3f'),'Visible','on')
        set(UI_i_A_MW_wert,'String',num2str(MW_i_A,'%6.3f'),'Visible','on')
        set(UI_R_VH_MW_wert,'String',num2str(MW_R_VH,'%6.3f'),'Visible','on')
    end

  

    function renew_Plots_zoom(source,callbackdata)
        %x-Werte in UIs übernehmen
        X_Limits_zoom = get(Achse_1,'XLim');
        set(UI_Zeit_min,'String',num2str(X_Limits_zoom(1),'%6.3f'));
        set(UI_Zeit_max,'String',num2str(X_Limits_zoom(2),'%6.3f'));
        clear X_Limits_zoom
        
        %y-Werte in UIs Achse_1 übernehmen
        Y_Limits_zoom = get(Achse_1,'YLim');
        set(UI_U_A_min,'String',num2str(Y_Limits_zoom(1),'%6.3f'));
        set(UI_U_A_max,'String',num2str(Y_Limits_zoom(2),'%6.3f'));
        clear Y_Limits_zoom
        
        %y-Werte in UIs Achse_2 übernehmen
        Y_Limits_zoom = get(Achse_2,'YLim');
        set(UI_i_A_min,'String',num2str(Y_Limits_zoom(1),'%6.3f'));
        set(UI_i_A_max,'String',num2str(Y_Limits_zoom(2),'%6.3f'));
        clear Y_Limits_zoom
        
        %y-Werte in UIs Achse_2 übernehmen
        Y_Limits_zoom = get(Achse_3,'YLim');
        set(UI_R_VH_min,'String',num2str(Y_Limits_zoom(1),'%6.3f'));
        set(UI_R_VH_max,'String',num2str(Y_Limits_zoom(2),'%6.3f'));
        clear Y_Limits_zoom
    end

    uiwait(Fig)
        
end