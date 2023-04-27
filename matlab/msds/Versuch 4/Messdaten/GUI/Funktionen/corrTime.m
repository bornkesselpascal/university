%% Funktion zur Korrektur von Zeitfachsenehlern
function [t_sort,Indizes] = corrTime(t,DatenString,Variante)
    
    if Variante == 1
        [t_sort,Indizes] = sort(t);
        if ~isempty(Indizes)
            disp(['Zeitache ' DatenString ' wurde umsortiert, da nicht streng monoton steigend']);
        end
    elseif Variante == 2
        %hier ist noch eine verbesserte Variante zu implementieren
        dt_min = min(abs(diff(t)));
        dt_max = max(abs(diff(t))); 
        if (~isempty(dt_max) && dt_max > 3*dt_min)
            disp(['Aufgrund eines Zeitachsenfehler werden die ' DatenString ' Daten verworfen']);
            t_sort = [];
            Indizes = [];
        else
            t_sort = t;
            Indizes = 1:length(t);
        end
        clear dt_min dt_max
    end
            
end