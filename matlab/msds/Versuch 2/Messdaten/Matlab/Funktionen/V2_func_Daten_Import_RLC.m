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

