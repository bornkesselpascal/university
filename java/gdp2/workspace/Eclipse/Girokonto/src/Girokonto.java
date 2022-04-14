public class Girokonto {

	private String kontonummer;
	private double kontostand;
	private double dispo;
	
	public Girokonto(String pKontonummer, double pDispo) {
		kontonummer = pKontonummer;
		kontostand = 0.0;
		setDispo(pDispo);
	}
	
	public String getKontonummer() {
		return kontonummer;
	}
	
	public double getKontostand() {
		return kontostand;
	}
	
	public double getDispo() {
		return dispo;
	}
	
	public void setDispo(double pDispo) {
		if (pDispo >= 0) {
			dispo = pDispo;
		}
		else {
			dispo = 0.0;
		}
	}
	
	public void zahleEin(double betrag) {
		kontostand += betrag;
	}
	
	public void zahleAus(double betrag) {	
		
		if(kontostand - betrag >= -dispo) {
			kontostand -= betrag;
		}
		else {
			System.out.println("Der Verfügungsrahmen wurde überschritten. Die Auszahlung wurde nicht durchgeführt.");
		}
	}

}
