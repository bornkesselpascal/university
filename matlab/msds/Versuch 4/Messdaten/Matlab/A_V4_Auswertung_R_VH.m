ActPath = pwd;
%Pfad für Funktionen
addpath([ActPath '/Funktionen'])


%Auswertung der Ankerparameter
cd('../Daten')
[File,Path] = uigetfile({'*.mat'},'Messdatenfiles für Ermittlung der H-Brückenverluste auswählen','MultiSelect','on');
cd(ActPath)
if ~isnumeric(File)
    if iscell(File)
        for i = 1:length(File)
            Infos.fileName = File{i};
            load(fullfile(Path,File{i}))
            V4_GUI_R_VH(Zeit,U_B,i_A,v_rot,PWM_EM,Infos)
        end
    else
        Infos.fileName = File;
        load(fullfile(Path,File))
        V4_GUI_R_VH(Zeit,U_B,i_A,v_rot,PWM_EM,Infos)
    end
end

clear ActPath File Path Zeit x_lin v_lin x_rot v_rot Status U_B i_A PWM_EM a a_x a_z i Infos