/*
 * BEISPIEL ZUR ÜBERLADUNG VON METHODEN - KAPITEL 3.7
 * 
 * Die Methode "setSeitenlaengen" existiert drei mal und besitzt unterschiedliche Parameterlisten.
 * Anzahl und/oder Typen der Parameter müssen sich dabei unterscheiden. Das ist auch zum Beispiel
 * bei Konstruktoren möglich. 
 */

public class Rechteck {

	private double hoehe;
	private double breite;
	
	public Rechteck(double pHoehe, double pBreite) {
		setSeitenlaengen(pHoehe, pBreite);
	}
	
	public Rechteck (double laenge) {
		this(laenge, laenge);
	}
	
	public double getHoehe() {
		return hoehe;
	}
	
	public double getBreite() {
		return breite;
	}
	
	public void setSeitenlaengen(double pHoehe, double pBreite) {
		if (pHoehe > 0.0)
			hoehe = pHoehe;
		else
			hoehe = 0.0;
		
		if (pBreite > 0.0)
			breite = pBreite;
		else
			breite = 0.0;
	}
	
	public void setSeitenlaengen(double laenge) {
		setSeitenlaengen(laenge, laenge);
		System.out.println("Dies ist ein Quadrat.");
	}
	
	public void setSeitenlaengen(Rechteck rechteck) {
		setSeitenlaengen(rechteck.hoehe, rechteck.breite);
	}
	
		
}
