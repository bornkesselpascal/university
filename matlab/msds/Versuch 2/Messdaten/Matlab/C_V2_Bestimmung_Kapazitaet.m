%zunächst Workspace leeren
clear all

%aktuellen Arbeitspfad bestimmen und Pfade zufügen bzw ändern
ActPath = pwd;
addpath([pwd '\Funktionen'])

cd ../Daten

%Laden der Daten
[File,Path] = uigetfile({'*.mat;*.csv','Messdaten-Files (*.mat,*.csv)';'*.*',  'All Files (*.*)'}, ...
   'Wählen Sie ein Messdaten-File (Kondensator)');
cd(ActPath)

if ~isnumeric(File)
    Infos.fileName = File;
    [Zeit,Kanal_A,Kanal_B] = V2_func_Daten_Import_RLC(File,Path);
    Spannung_1 = Kanal_A-min(Kanal_A);
    Spannung_2 = Kanal_B-min(Kanal_B);
    V2_GUI_Zeitkonstante_Kondensator(Zeit,Spannung_1,Spannung_2,Infos)
end

clear File Path ActPath