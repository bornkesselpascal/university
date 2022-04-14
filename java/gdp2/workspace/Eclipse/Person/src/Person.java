import java.util.GregorianCalendar;
import java.util.Calendar;
import java.util.regex.Pattern;

public class Person {

	private String anrede;
	private String vorname;
	private String name;
	protected String gebdatum;
	
	private static int personenzahl = 0;
	
	public Person(String pAnrede, String pVorname, String pName, String pGebdatum){
		
		// Setter (z.B. mit Überprüfungscode) können auch im Konstruktor verwendet werden
		setAnrede(pAnrede);
		
		vorname = pVorname;
		name = pName;
		
		if (pGebdatum != null) {
			
			// Enthält automatisch das heutige Datum
			GregorianCalendar heute = new GregorianCalendar();
			
			String[] datumTeile = pGebdatum.split(Pattern.quote("."));
			
			GregorianCalendar datum = new GregorianCalendar(
					Integer.parseUnsignedInt(datumTeile[2]),
					Integer.parseUnsignedInt(datumTeile[1]),
					Integer.parseUnsignedInt(datumTeile[0]));
			
			if(datum.before(heute)) {
				gebdatum = pGebdatum;
			}
		}
		
		personenzahl++;
	}
	
	public boolean hatGeburtstag() {
		
		if (gebdatum == null) {
			return false;
		}
		
		GregorianCalendar heute = new GregorianCalendar();
		String[] datumTeile = gebdatum.split(Pattern.quote("."));
		
		return /*Integer.parseUnsignedInt(datumTeile[1]) - 1 == heute.get(Calendar.MONTH) && */
				Integer.parseUnsignedInt(datumTeile[0]) == heute.get(Calendar.DATE);
	}
	
	public String toString() {
		
		String personData = "";
		
		if(!anrede.equals("")) {
			personData = anrede + " " ;
		}
		
		personData = personData + vorname + " " + name;
		
		if(gebdatum != null) {
			personData = personData + " geboren am " + gebdatum;
		}
		
		return personData;
	}
	
	public String getVorname() {
		return vorname;
	}
	
	public void setAnrede(String pAnrede) {
		
		if (pAnrede.equals("Frau") || pAnrede.equals("Herr")) {
			anrede = pAnrede;
		}
		else {
			anrede = "";
		}
	}
	
	public static int getPersonenzahl() {
		/*
		 * STATIC - KAPITEL 4.1
		 * 
		 * Statische Attribute sind für alle Objekte gleich. Auf sie (+ statische Methoden) mit dem Klassennamen zugegfriffen.
		 * Diese Attribute können zum Beispiel 
		 */
		
		return personenzahl;
	}
	
	public boolean equals(Object other) {
		/*
		 * EQUALS-METHODE - KAPITEL 3.8
		 * 
		 * Da ein Typ "Object" übergeben werden muss bei der equals-Methode, ist ein Cast auf Person notwendig.		
		 */
		
		return name.equals(((Person) other).name) &&
				vorname.equals(((Person) other).vorname) &&
				gebdatum.equals(((Person) other).gebdatum);
	}
}
