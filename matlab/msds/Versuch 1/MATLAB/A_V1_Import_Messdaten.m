%Laden der Daten
[File,Path] = uigetfile('*.mat','MATLAB-Datenfile wählen');
if ~isnumeric(File)
    %File öffnen
    load(fullfile(Path,File))
    Zeit = Zeit';
    Amplitude = Amplitude';
    Zeit(end) = round(Zeit(end),3);
end