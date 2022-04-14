import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.regex.Pattern;

public class Mitarbeiter extends Person{

	private String id;
	private double gehalt;
	
	public Mitarbeiter(String pAnrede, String pVorname, String pName, String pGeb, String pId, double pGehalt) {
		
		/*
		 * Es muss ein Konstruktor der Basisklasse aufgerufen werden.
		 */
		
		super(pAnrede, pVorname, pName, pGeb);
		
		id = pId;
		gehalt = pGehalt;
	}

	public String getId() {
		return id;
	}

	public double getGehalt() {
		return gehalt;
	}
	
	public void erhoeheGehalt() {
		if(hatGeburtstag()) {
			int aktJahr = (new GregorianCalendar()).get(Calendar.YEAR);
			String[] datumTeile = gebdatum.split(Pattern.quote("."));
			
			if(aktJahr - Integer.parseInt(datumTeile[2]) < 40 ) {
				gehalt = gehalt * 2.15;
			}
			else {
				gehalt = gehalt * 2.5;
			}
		}
	}
	
}
