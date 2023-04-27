function A_Fahrzeug_GUI

    fclose('all'); % close all open files
    close all; % close all figures
    clear all; % clear all workspace variables
    clc; % clear the command line
    delete(instrfindall); % Reset Com Port
    delete(timerfindall); % Delete Timers
    
    Main_Path = pwd;
    Function_Path = [pwd '/Funktionen'];
    Default_Savepath = [pwd '/../Daten'];
    
    addpath(Main_Path)
    addpath(Function_Path)
    
    global Zeit x_lin x_rot v_lin v_rot a a_x a_z Strom Spannung Ansteuerung_EM Status
    global Zeit_save x_lin_save x_rot_save v_lin_save v_rot_save a_save a_x_save a_z_save Strom_save Spannung_save Ansteuerung_EM_save Status_save
    global Error_Counter Disp_Errors Success_Counter Experten_Modus Position_Ref Flag_Synchro Offset_Synchro_xlin Offset_Synchro_xrot
    
    Experten_Modus = 0;
    Test_Modus = 0;
    Schriftgroesse = 12;
    Schriftdicke = 'bold';
    
    Error_Counter = 0;
    Success_Counter = 0;
    Disp_Errors = 0;
    Position_Ref = 0;
    Flag_Synchro = false;
    Offset_Synchro_xlin = 0;
    Offset_Synchro_xrot = 0;
    
    Zeit = [];
    x_lin = [];
    x_rot = [];
    v_lin = [];
    v_rot = [];
    a = [];
    a_x = [];
    a_z = [];
    Strom = [];
    Spannung = [];
    Ansteuerung_EM = [];
    Status = [];
    
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
      
    % Konstanten
    BAUDRATE = 115200;
    INPUTBUFFER = 8192;
    TMR_PERIOD_DATA = 0.1;
    TMR_PERIOD_SEND = 0.025;
    %COM_PORT = "COM3"; % blaue Platine
    COM_PORT = "COM5"; % grüne Platine
    
    % Variablen
    COM_available = 0;
    Flag_COM_ready = 0;

    % --------------------------------------------
    % Erzeugen der Figure mit Plots und UIControls
    % --------------------------------------------
    
    %% Figure
    %  ------
    clf
    Figure.Ausgabe = figure(1);
    set(Figure.Ausgabe,'Units','normalized','Position',[0 0.05 1 0.92],'MenuBar','none','ToolBar','none','Visible','off');
    % dauerhafte Aktivierung zum Testen
    if Test_Modus == 1
        Figure.Ausgabe.Visible = 'on';
    end

    
    %% Axes
    %  ----
    x_Limits = [0 10];  %x-Achsenbereich in [s]
    y_Limits = [-8 8];  %y-Achsenbereich in [mm]
    %y_LimMode = 'auto';
    y_LimMode = 'manual';
    
   
    y_Limits = [-250 1400];
    Achse.Weg = axes('XLim',x_Limits,'YLim',y_Limits,'YLimMode',y_LimMode,'Units','normalized',...
                          'Position',[0.23 0.69 0.35 0.26],'Box','on','XGrid','on','YGrid','on');
    Achse.Weg.Title.String = 'Weg [mm]';
    Achse.Weg.Title.FontSize = 12;
    Achse.Weg.Title.FontWeight = 'bold';
    Achse.Weg.UserData = y_Limits;

    y_Limits = [-3 3];
    Achse.Geschwindigkeit = axes('XLim',x_Limits,'YLim',y_Limits,'YLimMode',y_LimMode,'Units','normalized',...
                          'Position',[0.23 0.37 0.35 0.26],'Box','on','XGrid','on','YGrid','on');
    Achse.Geschwindigkeit.Title.String = 'Geschwindigkeit [m/s]';
    Achse.Geschwindigkeit.Title.FontSize = 12;
    Achse.Geschwindigkeit.Title.FontWeight = 'bold';
    Achse.Geschwindigkeit.UserData = y_Limits;
    
    y_Limits = [-10 10];
    Achse.Beschleunigung = axes('XLim',x_Limits,'YLim',y_Limits,'YLimMode',y_LimMode,'Units','normalized',...
                        'Position',[0.23 0.05 0.35 0.26],'Box','on','XGrid','on','YGrid','on');
    Achse.Beschleunigung.Title.String = 'Beschleunigung [m/s^2]';
    Achse.Beschleunigung.Title.FontSize = 12;
    Achse.Beschleunigung.Title.FontWeight = 'bold';
    Achse.Beschleunigung.UserData = y_Limits;

    y_Limits = [0 3];
    Achse.Strom = axes('XLim',x_Limits,'YLim',y_Limits,'YLimMode',y_LimMode,'Units','normalized',...
                        'Position',[0.63 0.69 0.35 0.26],'Box','on','XGrid','on','YGrid','on');
    Achse.Strom.Title.String = 'Strom [A]';
    Achse.Strom.Title.FontSize = 12;
    Achse.Strom.Title.FontWeight = 'bold';
    Achse.Strom.UserData = y_Limits;
    
    y_Limits = [0 15];
    Achse.Spannung = axes('XLim',x_Limits,'YLim',y_Limits,'YLimMode',y_LimMode,'Units','normalized',...
                        'Position',[0.63 0.37 0.35 0.26],'Box','on','XGrid','on','YGrid','on');
    Achse.Spannung.Title.String = 'Spannung [V]';
    Achse.Spannung.Title.FontSize = 12;
    Achse.Spannung.Title.FontWeight = 'bold';
    Achse.Spannung.UserData = y_Limits;
    
    y_Limits = [-110 110];
    Achse.Ansteuerung = axes('XLim',x_Limits,'YLim',y_Limits,'YLimMode',y_LimMode,'Units','normalized',...
                        'Position',[0.63 0.05 0.35 0.26],'Box','on','XGrid','on','YGrid','on');
    Achse.Ansteuerung.Title.String = 'Ansteuerung EM [-]';
    Achse.Ansteuerung.Title.FontSize = 12;
    Achse.Ansteuerung.Title.FontWeight = 'bold';
    Achse.Ansteuerung.UserData = y_Limits;

    clear x_Limits y_limits

    %% Lines
    %  -----
    LinienBreite = 2;
    
    Linie.Weg_lin = animatedline('Parent',Achse.Weg,'Color','b','LineWidth',LinienBreite);
    Linie.Weg_rot = animatedline('Parent',Achse.Weg,'Color','r','LineWidth',LinienBreite);
    
    Linie.Geschwindigkeit_lin = animatedline('Parent',Achse.Geschwindigkeit,'Color','b','LineWidth',LinienBreite);
    Linie.Geschwindigkeit_rot = animatedline('Parent',Achse.Geschwindigkeit,'Color','r','LineWidth',LinienBreite);
    
    Linie.Beschleunigung = animatedline('Parent',Achse.Beschleunigung,'Color','b','LineWidth',LinienBreite);
    Linie.Beschleunigung_x = animatedline('Parent',Achse.Beschleunigung,'Color','r','LineWidth',LinienBreite);
    Linie.Beschleunigung_z = animatedline('Parent',Achse.Beschleunigung,'Color',[0 0.5 0],'LineWidth',LinienBreite);
    
    Linie.Strom = animatedline('Parent',Achse.Strom,'Color','b','LineWidth',LinienBreite);
    
    Linie.Spannung = animatedline('Parent',Achse.Spannung,'Color','b','LineWidth',LinienBreite);
    
    Linie.Ansteuerung = animatedline('Parent',Achse.Ansteuerung,'Color','b','LineWidth',LinienBreite);

    %% UIControls
    %  ----------                    
    % Serielle Datenübertragung aktivieren/deaktivieren
    UI.Seriell_EinAus = uicontrol('Parent',Figure.Ausgabe,'Style','toggle','Units','normalized','Position',[0.01 0.89 0.18 0.09],'FontSize',14,'String','Serielle-Daten ein');
    UI.Seriell_EinAus.Enable = 'off'; 
    
    % Speichern der Daten aktivieren/deaktivieren
    UI.Speichern_EinAus = uicontrol('Parent',Figure.Ausgabe,'Style','toggle','Units','normalized','Position',[0.01 0.81 0.18 0.07],'FontSize',14,'String','Messdaten speichern '); 
    UI.Speichern_EinAus.Value = 0;
    UI.Speichern_EinAus.Enable = 'off';
    UI.Speichern_EinAus.Visible = 'on';     
    
    % Ausgabe des gemessenen Abstands (zu Kalibrierzwecken)
    UI.xlin_edit = uicontrol('Parent',Figure.Ausgabe,'Style','edit','Units','normalized','Position',[0.45 0.955 0.05 0.035],'String','0');
    UI.xlin_edit.Enable = 'inactive';
    UI.xlin_edit.Visible = 'on';
    UI.xlin_edit.FontSize = 14;
    % Ausgabe der Differenz der x-Werte
    UI.xdiff_text = uicontrol('Parent',Figure.Ausgabe,'Style','text','Units','normalized','Position',[0.51 0.953 0.02 0.035],'String','Diff');
    UI.xdiff_text.Visible = 'on';
    UI.xdiff_text.FontSize = 12;
    
    UI.xdiff_edit = uicontrol('Parent',Figure.Ausgabe,'Style','edit','Units','normalized','Position',[0.53 0.955 0.05 0.035],'String','0');
    UI.xdiff_edit.Enable = 'inactive';
    UI.xdiff_edit.Visible = 'on';
    UI.xdiff_edit.FontSize = 14;
    
    
    % PWM-Wert für Ausgabe am EM-Controller
    UI.PWM_text = uicontrol('Parent',Figure.Ausgabe,'Style','text','Units','normalized','Position',[0.01 0.65 0.1 0.04],'String','PWM-Wert [%]');
    UI.PWM_text.Enable = 'off';
    UI.PWM_text.Visible = 'on';
    UI.PWM_text.FontSize = 14;
    
    UI.PWM_edit = uicontrol('Parent',Figure.Ausgabe,'Style','edit','Units','normalized','Position',[0.11 0.653 0.08 0.04],'String','0');
    UI.PWM_edit.Enable = 'off';
    UI.PWM_edit.Visible = 'on';
    UI.PWM_edit.UserData = str2num(UI.PWM_edit.String);
    UI.PWM_edit.FontSize = 14;
    
    UI.PWM_send = uicontrol('Parent',Figure.Ausgabe,'Style','toggle','Units','normalized','Position',[0.01 0.6 0.18 0.04],'FontSize',14,'String',' ausgeben '); 
    UI.PWM_send.Enable = 'off';
    UI.PWM_send.Visible = 'on';
    
    % Profilauswahl
    UI.Profilwahl_text = uicontrol('Parent',Figure.Ausgabe,'Style','text','Units','normalized','Position',[0.01 0.5 0.18 0.04],'String','Fahrprofilwahl');
    UI.Profilwahl_text.Enable = 'off';
    UI.Profilwahl_text.Visible = 'on';
    UI.Profilwahl_text.FontSize = 16;
    
    UI.Profilwahl = uicontrol('Parent',Figure.Ausgabe,'Style','popup','Units','normalized','Position',[0.01 0.46 0.18 0.04],...
                              'String',{'Sprung 25','Sprung 30','Sprung 35','Sprung 40','Profil Sägezahn Teflon','Profil Sägezahn Stahl'});
    UI.Profilwahl.Enable = 'off';
    UI.Profilwahl.Visible = 'on';
    UI.Profilwahl.FontSize = 14;
    UI.Profilwahl.FontWeight = 'bold';
    UI.Profilwahl.UserData = 1;
    
    UI.Profilwahl_Start = uicontrol('Parent',Figure.Ausgabe,'Style','pushbutton','Units','normalized','Position',[0.01 0.41 0.09 0.04],'FontSize',14,'String',' Start '); 
    UI.Profilwahl_Start.Enable = 'off';
    UI.Profilwahl_Start.Visible = 'on';
    
    UI.Profilwahl_Stop = uicontrol('Parent',Figure.Ausgabe,'Style','pushbutton','Units','normalized','Position',[0.1 0.41 0.09 0.04],'FontSize',14,'String',' Stop '); 
    UI.Profilwahl_Stop.Enable = 'off';
    UI.Profilwahl_Stop.Visible = 'on';
    
    
    % Nullpunkt und Synchropunkt
    UI.Nullpunkt_text = uicontrol('Parent',Figure.Ausgabe,'Style','text','Units','normalized','Position',[0.01 0.30 0.13 0.04],'String','Nullpunkt [mm]');
    UI.Nullpunkt_text.Enable = 'off';
    UI.Nullpunkt_text.Visible = 'on';
    UI.Nullpunkt_text.FontSize = 14;
    
    UI.Nullpunkt_edit = uicontrol('Parent',Figure.Ausgabe,'Style','edit','Units','normalized','Position',[0.14 0.303 0.05 0.04],'String','250');
    UI.Nullpunkt_edit.Enable = 'off';
    UI.Nullpunkt_edit.Visible = 'on';
    UI.Nullpunkt_edit.UserData = str2num(UI.Nullpunkt_edit.String);
    UI.Nullpunkt_edit.FontSize = 14;
    
    UI.Synchro_text = uicontrol('Parent',Figure.Ausgabe,'Style','text','Units','normalized','Position',[0.01 0.25 0.13 0.04],'String','Synchro-Punkt [mm]');
    UI.Synchro_text.Enable = 'off';
    UI.Synchro_text.Visible = 'on';
    UI.Synchro_text.FontSize = 14;
    
    UI.Synchro_edit = uicontrol('Parent',Figure.Ausgabe,'Style','edit','Units','normalized','Position',[0.14 0.253 0.05 0.04],'String','500');
    UI.Synchro_edit.Enable = 'off';
    UI.Synchro_edit.Visible = 'on';
    UI.Synchro_edit.UserData = str2num(UI.Synchro_edit.String);
    UI.Synchro_edit.FontSize = 14;
    
    UI.Synchro_new = uicontrol('Parent',Figure.Ausgabe,'Style','pushbutton','Units','normalized','Position',[0.01 0.2 0.18 0.04],'FontSize',14,'String',' neu synchronisieren '); 
    UI.Synchro_new.Enable = 'off';
    UI.Synchro_new.Visible = 'off';
    
    % Status als Zahlenwert
    UI.Status_text = uicontrol('Parent',Figure.Ausgabe,'Style','text','Units','normalized','Position',[0.04 0.16 0.07 0.03],'String','Status');
    UI.Status_text.Enable = 'off';
    UI.Status_text.Visible = 'off';
    UI.Status_text.FontSize = 14;
    
    UI.Status_edit = uicontrol('Parent',Figure.Ausgabe,'Style','edit','Units','normalized','Position',[0.11 0.165 0.05 0.03],'String','0');
    UI.Status_edit.Enable = 'inactive';
    UI.Status_edit.Visible = 'off';
    UI.Status_edit.UserData = str2num(UI.Status_edit.String);
    UI.Status_edit.FontSize = 14;
    
    % Buttons für Status (aktuelle Werte) 
    UI.Status_Button_Text = uicontrol('Parent',Figure.Ausgabe,'Style','text','Units','normalized','Position',[0.01 0.1 0.07 0.03],'String','Status (akt)');
    UI.Status_Button_Text.Enable = 'off';
    UI.Status_Button_Text.Visible = 'on';
    UI.Status_Button_Text.FontSize = 12;
    
    UI.Status_Button0 = uicontrol('Parent',Figure.Ausgabe,'Style','radiobutton','Units','normalized','Position',[0.185 0.1 0.015 0.03]);
    UI.Status_Button0.Enable = 'off';
    UI.Status_Button0.Visible = 'on';
    UI.Status_Button0.FontSize = 8;
    UI.Status_Button0.String = "";
    UI.Status_Button0.Value = 0;
    
    UI.Status_Button1 = uicontrol('Parent',Figure.Ausgabe,'Style','radiobutton','Units','normalized','Position',[0.17 0.1 0.015 0.03]);
    UI.Status_Button1.Enable = 'off';
    UI.Status_Button1.Visible = 'on';
    UI.Status_Button1.FontSize = 8;
    UI.Status_Button1.String = "";
    UI.Status_Button1.Value = 0;
    
    UI.Status_Button2 = uicontrol('Parent',Figure.Ausgabe,'Style','radiobutton','Units','normalized','Position',[0.155 0.1 0.015 0.03]);
    UI.Status_Button2.Enable = 'off';
    UI.Status_Button2.Visible = 'on';
    UI.Status_Button2.FontSize = 8;
    UI.Status_Button2.String = "";
    UI.Status_Button2.Value = 0;
    
    UI.Status_Button3 = uicontrol('Parent',Figure.Ausgabe,'Style','radiobutton','Units','normalized','Position',[0.14 0.1 0.015 0.03]);
    UI.Status_Button3.Enable = 'off';
    UI.Status_Button3.Visible = 'on';
    UI.Status_Button3.FontSize = 8;
    UI.Status_Button3.String = "";
    UI.Status_Button3.Value = 0;
    
    UI.Status_Button4 = uicontrol('Parent',Figure.Ausgabe,'Style','radiobutton','Units','normalized','Position',[0.125 0.1 0.015 0.03]);
    UI.Status_Button4.Enable = 'off';
    UI.Status_Button4.Visible = 'on';
    UI.Status_Button4.FontSize = 8;
    UI.Status_Button4.String = "";
    UI.Status_Button4.Value = 0;
    
    UI.Status_Button5 = uicontrol('Parent',Figure.Ausgabe,'Style','radiobutton','Units','normalized','Position',[0.11 0.1 0.015 0.03]);
    UI.Status_Button5.Enable = 'off';
    UI.Status_Button5.Visible = 'on';
    UI.Status_Button5.FontSize = 8;
    UI.Status_Button5.String = "";
    UI.Status_Button5.Value = 0;
    
    UI.Status_Button6 = uicontrol('Parent',Figure.Ausgabe,'Style','radiobutton','Units','normalized','Position',[0.095 0.1 0.015 0.03]);
    UI.Status_Button6.Enable = 'off';
    UI.Status_Button6.Visible = 'on';
    UI.Status_Button6.FontSize = 8;
    UI.Status_Button6.String = "";
    UI.Status_Button6.Value = 0;
    
    UI.Status_Button7 = uicontrol('Parent',Figure.Ausgabe,'Style','radiobutton','Units','normalized','Position',[0.08 0.1 0.015 0.03]);
    UI.Status_Button7.Enable = 'off';
    UI.Status_Button7.Visible = 'on';
    UI.Status_Button7.FontSize = 8;
    UI.Status_Button7.String = "";
    UI.Status_Button7.Value = 0;
    
    % Buttons für Status (gehaltene Werte) 
    UI.Status_hold_Button_Text = uicontrol('Parent',Figure.Ausgabe,'Style','text','Units','normalized','Position',[0.01 0.05 0.07 0.03],'String','Status (hold)');
    UI.Status_hold_Button_Text.Enable = 'off';
    UI.Status_hold_Button_Text.Visible = 'on';
    UI.Status_hold_Button_Text.FontSize = 12;
    UI.Status_hold_Button_Text.UserData = 1;
    
    UI.Status_hold_Button0 = uicontrol('Parent',Figure.Ausgabe,'Style','radiobutton','Units','normalized','Position',[0.185 0.05 0.015 0.03]);
    UI.Status_hold_Button0.Enable = 'off';
    UI.Status_hold_Button0.Visible = 'on';
    UI.Status_hold_Button0.FontSize = 8;
    UI.Status_hold_Button0.String = "";
    UI.Status_hold_Button0.Value = 0;
    
    UI.Status_hold_Button1 = uicontrol('Parent',Figure.Ausgabe,'Style','radiobutton','Units','normalized','Position',[0.17 0.05 0.015 0.03]);
    UI.Status_hold_Button1.Enable = 'off';
    UI.Status_hold_Button1.Visible = 'on';
    UI.Status_hold_Button1.FontSize = 8;
    UI.Status_hold_Button1.String = "";
    UI.Status_hold_Button1.Value = 0;
    
    UI.Status_hold_Button2 = uicontrol('Parent',Figure.Ausgabe,'Style','radiobutton','Units','normalized','Position',[0.155 0.05 0.015 0.03]);
    UI.Status_hold_Button2.Enable = 'off';
    UI.Status_hold_Button2.Visible = 'on';
    UI.Status_hold_Button2.FontSize = 8;
    UI.Status_hold_Button2.String = "";
    UI.Status_hold_Button2.Value = 0;
    
    UI.Status_hold_Button3 = uicontrol('Parent',Figure.Ausgabe,'Style','radiobutton','Units','normalized','Position',[0.14 0.05 0.015 0.03]);
    UI.Status_hold_Button3.Enable = 'off';
    UI.Status_hold_Button3.Visible = 'on';
    UI.Status_hold_Button3.FontSize = 8;
    UI.Status_hold_Button3.String = "";
    UI.Status_hold_Button3.Value = 0;
    
    UI.Status_hold_Button4 = uicontrol('Parent',Figure.Ausgabe,'Style','radiobutton','Units','normalized','Position',[0.125 0.05 0.015 0.03]);
    UI.Status_hold_Button4.Enable = 'off';
    UI.Status_hold_Button4.Visible = 'on';
    UI.Status_hold_Button4.FontSize = 8;
    UI.Status_hold_Button4.String = "";
    UI.Status_hold_Button4.Value = 0;
    
    UI.Status_hold_Button5 = uicontrol('Parent',Figure.Ausgabe,'Style','radiobutton','Units','normalized','Position',[0.11 0.05 0.015 0.03]);
    UI.Status_hold_Button5.Enable = 'off';
    UI.Status_hold_Button5.Visible = 'on';
    UI.Status_hold_Button5.FontSize = 8;
    UI.Status_hold_Button5.String = "";
    UI.Status_hold_Button5.Value = 0;
    
    UI.Status_hold_Button6 = uicontrol('Parent',Figure.Ausgabe,'Style','radiobutton','Units','normalized','Position',[0.095 0.05 0.015 0.03]);
    UI.Status_hold_Button6.Enable = 'off';
    UI.Status_hold_Button6.Visible = 'on';
    UI.Status_hold_Button6.FontSize = 8;
    UI.Status_hold_Button6.String = "";
    UI.Status_hold_Button6.Value = 0;
    
    UI.Status_hold_Button7 = uicontrol('Parent',Figure.Ausgabe,'Style','radiobutton','Units','normalized','Position',[0.08 0.05 0.015 0.03]);
    UI.Status_hold_Button7.Enable = 'off';
    UI.Status_hold_Button7.Visible = 'on';
    UI.Status_hold_Button7.FontSize = 8;
    UI.Status_hold_Button7.String = "";
    UI.Status_hold_Button7.Value = 0;
    
    
    %% Verbindung aufbauen
    %  -------------------
    %Prüfen ob COM-Ports verfügbar (abhängig von Matlab-Version, ab 2019 anders)
    Matlab_Version = version('-release');
    Matlab_Version = str2num(Matlab_Version(1:end-1));
    if Matlab_Version < 2019
        COM_Ports_verf = instrhwinfo('serial');
        COM_Ports_verf = COM_Ports_verf.AvailableSerialPorts;
    else
        COM_Ports_verf = serialportlist("available");
        %COM_Ports_verf = COM_PORT;
    end
    
    %COM-Port öffnen
    if (~isempty(COM_Ports_verf))
        if (max(strcmp(COM_Ports_verf,COM_PORT)) == 0)
            errordlg(['COM-Port ' COM_PORT ' nicht verfügbar'],'COM-Port Error');          
        else
            UI.Seriell_EinAus.Enable = 'on';
            %% Erzeugen des seriellen Objekts
            board = serialport(COM_PORT, BAUDRATE, 'DataBits',8);
            COM_available = 1;
            %% Timer-Setup
            % Der Timer t_data hat eine callback-Funktion (getData), die die seriellen Daten liest 
            t_data = timer('Period', TMR_PERIOD_DATA);
            set(t_data,'ExecutionMode','fixedRate');
            set(t_data,'TimerFcn', @(x,y)getData(board,Achse,Linie,UI,t_data));
            % Der Timer t_send hat eine callback-Funktion (sendData), die die seriellen Daten liest 
            t_send = timer('Period', TMR_PERIOD_SEND);
            set(t_send,'ExecutionMode','fixedRate');
            set(t_send,'TimerFcn', @(x,y)sendData(board,UI,t_send,COM_available));
            Figure.Ausgabe.Visible = 'on';
        end
    else
        errordlg('Kein COM-Port verfügbar','COM-Port Error');
    end
    
    %% Definition der Callbacks für UIControls
    if COM_available == 1
        UI.Seriell_EinAus.Callback = {@UI_Seriell_EinAus,board,UI,Achse,t_data,t_send,COM_available};
        UI.PWM_send.Callback = {@UI_PWM_send,board,UI,t_data,COM_available};
    end
    UI.Speichern_EinAus.Callback = {@UI_Speichern_EinAus,Default_Savepath,UI};
    UI.PWM_edit.Callback = {@UI_PWM_edit,UI}; 
    UI.Nullpunkt_edit.Callback = {@UI_Nullpunkt_edit,UI};
    UI.Synchro_edit.Callback = {@UI_Synchro_edit,UI};
    UI.Synchro_new.Callback = {@UI_Synchro_new,UI};
    UI.Profilwahl.Callback = {@UI_Profilwahl,UI};
    UI.Profilwahl_Start.Callback = {@UI_Profilwahl_Start,UI};
    UI.Profilwahl_Stop.Callback = {@UI_Profilwahl_Stop,UI};
end
