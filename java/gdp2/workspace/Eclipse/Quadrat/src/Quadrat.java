public class Quadrat {

	// Das ist ein Attribut.
	private double seitenLaenge;
	
	public Quadrat(double pSeitenLaenge) {
		setSeitenLaenge (pSeitenLaenge);
	}
	
	public double getSeitenLaenge() {
		return seitenLaenge;
	}
	
	public void setSeitenLaenge(double pSeitenLaenge) {
		seitenLaenge = pSeitenLaenge;
	}
	
	public double berechneFlaeche() {
		return seitenLaenge * seitenLaenge;
	}
}
