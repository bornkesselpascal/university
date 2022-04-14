import java.util.Calendar;
import java.util.GregorianCalendar;

public class ShortPData {

    private String name;
    private String vorname;
    private GregorianCalendar gebdatum;

    public ShortPData(String pName, String pVorname, GregorianCalendar pGebdatum) {
        name = pName;
        vorname = pVorname;
        gebdatum = pGebdatum;
    }

    public String getName() {
        return name;
    }

    public String getVorname() {
        return vorname;
    }

    public GregorianCalendar getGebdatum() {
        return gebdatum;
    }

    @Override
    public boolean equals(Object obj) {
        return name.equals(((ShortPData) obj).name) && 
               vorname.equals(((ShortPData) obj).vorname) && 
               gebdatum.equals(((ShortPData) obj).gebdatum);
    }

    public String toString() {
        return name + ", " + vorname + ", " + 
               gebdatum.get(Calendar.DATE) + "." + 
        	   gebdatum.get(Calendar.MONTH) + "." + gebdatum.get(Calendar.YEAR);
    }

}
