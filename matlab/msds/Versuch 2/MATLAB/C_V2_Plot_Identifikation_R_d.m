function main()
    ActPath = pwd;
  
    cd Daten

    %Laden der Daten
    [File,Path] = uigetfile({'*.mat;*.csv','Messdaten-Files(*.mat,*.csv)';'*.*',  'All Files (*.*)'}, ...
       'Wählen Sie ein Messdaten-File (Spule)');
    cd(ActPath)

    if ~isnumeric(File)
        Infos.fileName = File;
        [Zeit,Kanal_A,Kanal_B] = V2_func_Daten_Import_RLC(File,Path);
        % Bei vertauschten Messkanälen die untenstehende Funktion aktivieren
        % [Zeit,Eingang,Ausgang] = V2_func_Daten_Import_RLC_Messkanaele_vertauscht(File,Path);
        V2_GUI_Daempfung(Zeit,Kanal_A,Kanal_B,Infos)
    end

    clear File Path ActPath

end

%% Funktionen

function [Zeit,Eingang,Ausgang] = V2_func_Daten_Import_RLC(File,Path)

    [pathstr,name,ext] = fileparts(fullfile(Path,File));
    clear pathstr name
        switch ext
            case '.mat'
                load(fullfile(Path,File))
                Zeit = ([0:Length-1]*Tinterval)';
                tstop = Zeit(end);
                Ausgang = B;
                Eingang = A(1:Length);
                clear Tinterval Tstart Length A B
            case '.csv'
                %File öffnen und Einheiten einlesen
                FID = fopen(fullfile(Path,File));
                Variablen_str = fgetl(FID);
                Einheiten_str = fgetl(FID);
                ID = fclose(FID);

                Index_auf = findstr(Einheiten_str,'(');
                Index_zu = findstr(Einheiten_str,')');

                if length(Index_auf) == length(Index_zu)
                    for i = 1:length(Index_auf)
                        Einheiten{i} = Einheiten_str(Index_auf(i)+1:Index_zu(i)-1);
                    end
                else
                    disp('Fehler')
                end
                %numerische Daten einlesen
                TempData = csvread(fullfile(Path,File),3,0);
                if strmatch(Einheiten{1},'us')
                    Zeit = (TempData(:,1)-TempData(1,1))/1e6;
                else 
                    Zeit = (TempData(:,1)-TempData(1,1))/1e3;
                end
                tstop = Zeit(end);
                Eingang = TempData(:,2);
                if strmatch(Einheiten{3},'mV')
                    Ausgang = TempData(:,3)/1000;
                else 
                    Ausgang = TempData(:,3);
                end
                clear TempData Einheiten Einheiten_str FID FileType i Index_auf ...
                      Index_zu Variablen_str ID
        end
end

function [Zeit,Eingang,Ausgang] = V2_func_Daten_Import_RLC_Messkanaele_vertauscht(File,Path)

    [pathstr,name,ext] = fileparts(fullfile(Path,File));
    clear pathstr name
        switch ext
            case '.mat'
                load(fullfile(Path,File))
                Zeit = ([0:Length-1]*Tinterval)';
                tstop = Zeit(end);
                Eingang = B;
                Ausgang = A(1:Length);
                clear Tinterval Tstart Length A B
            case '.csv'
                %File öffnen und Einheiten einlesen
                FID = fopen(fullfile(Path,File));
                Variablen_str = fgetl(FID);
                Einheiten_str = fgetl(FID);
                ID = fclose(FID);

                Index_auf = findstr(Einheiten_str,'(');
                Index_zu = findstr(Einheiten_str,')');

                if length(Index_auf) == length(Index_zu)
                    for i = 1:length(Index_auf)
                        Einheiten{i} = Einheiten_str(Index_auf(i)+1:Index_zu(i)-1);
                    end
                else
                    disp('Fehler')
                end
                %numerische Daten einlesen
                TempData = csvread(fullfile(Path,File),3,0);
                if strmatch(Einheiten{1},'us')
                    Zeit = (TempData(:,1)-TempData(1,1))/1e6;
                else 
                    Zeit = (TempData(:,1)-TempData(1,1))/1e3;
                end
                tstop = Zeit(end);
                Ausgang = TempData(:,2);
                if strmatch(Einheiten{3},'mV')
                    Eingang = TempData(:,3)/1000;
                else 
                    Einggang = TempData(:,3);
                end
                clear TempData Einheiten Einheiten_str FID FileType i Index_auf ...
                      Index_zu Variablen_str ID
        end
end

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

function output_txt = DataCursorEinst(obj,event_obj)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

    Digits = '%.6f';

    pos = get(event_obj,'Position');
    output_txt = {['t: ',num2str(pos(1),Digits)],...
        ['Y: ',num2str(pos(2),Digits)]};

    % If there is a Z-coordinate in the position, display it as well
    if length(pos) > 2
        output_txt{end+1} = ['Z: ',num2str(pos(3),Digits)];
    end
end