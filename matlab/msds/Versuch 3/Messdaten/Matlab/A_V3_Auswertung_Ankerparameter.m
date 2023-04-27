ActPath = pwd;
%Pfade für tdms-Import
addpath([ActPath '\Import_tdms\v2p5'])
addpath([ActPath '\Import_tdms\v2p5\tdmsSubfunctions'])
%Pfad für Funktionen
addpath([ActPath '\Funktionen'])

%Pfad für Messdaten auswählen
ui_data_path_on = 0;
if ui_data_path_on == 1
    data_path = uigetdir('../Daten','Pfad der Messdateien auswählen');
else
    data_path = '../Daten';
end
clear ui_data_path_on

%Löschen von *.tdms_index-Files falls vorhanden
cd(data_path)
Dateien = dir;
for i = 1:length(Dateien)
    if Dateien(i).isdir == 0
        [pathstr,name,ext] = fileparts(Dateien(i).name);
        if strmatch('.tdms_index',ext,'exact')
            delete(Dateien(i).name)
        end
    end
end
clear Dateien pathstr name ext
cd(ActPath)


%Auswertung der Ankerparameter
cd(data_path)
[filename_tdms,pathname_tdms] = uigetfile({'*.tdms'},'TDMS-Messdatenfiles für Ermittlung Ankerparameter auswählen','MultiSelect','on');
cd(ActPath)
if ~isnumeric(filename_tdms)
    if iscell(filename_tdms)
        for i = 1:length(filename_tdms)
            [Zeit,Spannung_EM_V,Strom_EM_A,Drehzahl_U_min,Drehzahl_U_min_TTL,Infos] = V3_Import_Messdaten_EM( pathname_tdms,filename_tdms{i});
            V3_GUI_Ankerparameter(Zeit,Spannung_EM_V,Strom_EM_A,Drehzahl_U_min,Infos)
        end
    else
        [Zeit,Spannung_EM_V,Strom_EM_A,Drehzahl_U_min,Drehzahl_U_min_TTL,Infos] = V3_Import_Messdaten_EM( pathname_tdms,filename_tdms);
        V3_GUI_Ankerparameter(Zeit,Spannung_EM_V,Strom_EM_A,Drehzahl_U_min,Infos)
    end
end

clear ActPath filename_tdms pathname_tdms Zeit Spannung_EM_V Strom_EM_A Drehzahl_U_min Drehzahl_U_min_TTL Infos i File Path data_path