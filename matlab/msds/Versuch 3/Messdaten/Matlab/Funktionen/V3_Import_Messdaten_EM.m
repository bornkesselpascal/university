function [Zeit,Spannung_EM_V,Strom_EM_A,Drehzahl_U_min,Drehzahl_U_min_TTL,Infos] = V3_Import_Messdaten_EM( pathname_tdms,filename_tdms)

    [Data,Infos] = TDMS_getStruct(fullfile(pathname_tdms,filename_tdms));

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

    %Korrektur Zeitvektor (Lösung des Problems Timer-Überlauf)
    Indizes = find(diff(Zeit)<0);
    if ~isempty(Indizes)
        for i = 1:length(Indizes)
           Zeit(Indizes(i)+1:end) = Zeit(Indizes(i)+1:end)+Zeit(Indizes(i));
        end
    end
    clear Indizes

    Zeit = Zeit-Zeit(1);

    clear Data ClusterNamen Index Zaehler i j DatenLaenge DatenNamen


    %temporäre Invertierung der Signale für Spannung und Strom
    %Spannung_EM__V_ = -Spannung_EM__V_;
    %Strom_EM__A_ = -Strom_EM__A_;

    %Auswertung Drehzahl aus TTL_Signal
    Faktor = 1;
    Indizes_st_Flanken = find(diff(TTL_norm__HI_LO_) == 1);
    st_Flanken = zeros(1,length(TTL_norm__HI_LO_));
    st_Flanken(Indizes_st_Flanken) = 1;
    Indizes_st_Flanken = Indizes_st_Flanken(1:Faktor:end);
    delta_t = diff(Zeit(Indizes_st_Flanken));
    omega = (Faktor*0.1*pi/180)./delta_t;
    n = 60*omega/2/pi;
    Drehzahl__U_min_ = zeros(1,length(Zeit));
    Drehzahl__U_min_(1:Indizes_st_Flanken) = 0;
    for i = 1:length(n)-1
        if delta_t(i) > 0.1         %wenn 100 ms keine Flanke kommt, wird auf Stillstand erkannt
            Drehzahl__U_min_(Indizes_st_Flanken(i):Indizes_st_Flanken(i+1)-1) = 0;
        else
            Drehzahl__U_min_(Indizes_st_Flanken(i):Indizes_st_Flanken(i+1)-1) = n(i);
        end
    end
    n_Vorzeichen = sign(Spannung_EM__V_);
    %Festlegung der Rückgabegrößen 
    Drehzahl_U_min_TTL = Drehzahl__U_min_.*n_Vorzeichen;
    Drehzahl_U_min = Drehzahl__1_min_.*n_Vorzeichen;
    Spannung_EM_V = Spannung_EM__V_;
    Strom_EM_A = Strom_EM__A_;
    
    clear Faktor Indizes_st_Flanken st_Flanken delta_t omega n n_Vorzeichen

end

