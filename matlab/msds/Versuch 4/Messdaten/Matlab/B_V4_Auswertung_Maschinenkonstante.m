ActPath = pwd;
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

%Auswertung der Maschinenkonstante
cd(data_path)
[File,Path] = uigetfile({'*.mat'},'Messdatenfiles für Ermittlung Maschinenkonstante auswählen','MultiSelect','on');
cd(ActPath)
if ~isnumeric(File)
    if iscell(File)
        for i = 1:length(File)
            Infos.fileName = File{i};
            load(fullfile(Path,File{i}))
            V4_GUI_Maschinenkonstante(Zeit,U_B,PWM_EM,i_A,v_rot,Infos)
        end
    else
        Infos.fileName = File;
        load(fullfile(Path,File))
        V4_GUI_Maschinenkonstante(Zeit,U_B,PWM_EM,i_A,v_rot,Infos)
    end
end

clear ActPath File Path Zeit x_lin v_lin x_rot v_rot a a_x a_z U_B i_A PWM_EM Status data_path i