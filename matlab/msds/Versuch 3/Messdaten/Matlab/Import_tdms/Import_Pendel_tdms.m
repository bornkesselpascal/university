ActPath = pwd;

addpath([ActPath '\v2p5'])
addpath([ActPath '\v2p5\tdmsSubfunctions'])

cd('C:\Meine_Daten\Vorlesungen\Modellbildung und Simulation\Messungen_Versuche')

Data = TDMS_getStruct;

%Extraktion Messkanäle
ClusterNamen = fields(Data);
Index = strfind(ClusterNamen,'Cluster');

Zaehler = 0;

for i = 1:length(Index)
    if Index{i} == 1
        eval(['DatenNamen = fields(Data.'  ClusterNamen{i} ');'])
        for j = 1:length(DatenNamen)
            if ((strcmp(DatenNamen(j),'name') == 0) && (strcmp(DatenNamen(j),'Props') == 0))
                eval([DatenNamen{j} ' = Data.' ClusterNamen{i} '.' DatenNamen{j} '.data;'])
                if Zaehler == 0
                    eval(['DatenLaenge = length(Data.' ClusterNamen{i} '.' DatenNamen{j} '.data);'])
                    Zaehler = 1;
                end
            end
        end
    end
end

%Generierung Zeitvektor;
%Zeit = [0:0.001:(DatenLaenge-1)*0.001];

cd(ActPath)

clear ActPath Data ClusterNamen Index Zaehler i j DatenLaenge DatenNamen