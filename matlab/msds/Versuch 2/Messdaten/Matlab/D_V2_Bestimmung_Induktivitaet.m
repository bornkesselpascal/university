%zunächst Workspace leeren
clear all

%aktuellen Arbeitspfad bestimmen und Pfade zufügen bzw ändern
ActPath = pwd;
addpath([pwd '\Funktionen'])

cd ../Daten

%Laden der Daten
[File,Path] = uigetfile({'*.mat;*.csv','Messdaten-Files(*.mat,*.csv)';'*.*',  'All Files (*.*)'}, ...
   'Wählen Sie ein Messdaten-File (Spule)');
cd(ActPath)

if ~isnumeric(File)
    Infos.fileName = File;
    [Zeit,Kanal_A,Kanal_B] = V2_func_Daten_Import_RLC(File,Path);
    Strom = (Kanal_B-2.5097)/0.186;
    
    %Nullpunktskorrektur
    Korr_on = 1;
    if Korr_on == 1
        Index = find(Zeit > 4.5e-3,1); % Bei 5e-3 sollte 1V erreicht sein, bei 4.5e-3 also sicher noch keine Spannung anliegen
        MW_Strom = mean(Strom(1:Index));
        Strom = Strom - MW_Strom;
        clear MW_Strom
    end
    
    V2_GUI_Zeitkonstante_Spule(Zeit,Kanal_A,Strom,Infos)
end

clear File Path ActPath