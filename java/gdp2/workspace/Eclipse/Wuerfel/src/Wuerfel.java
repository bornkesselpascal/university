public class Wuerfel {

	private double kantenlaenge;
	private static String farbe = "";
	
	public Wuerfel(double pKantenlaenge) {
		setKantenlaenge(pKantenlaenge);
	}
	
	public double berechneVolumen() {
		return Math.pow(kantenlaenge, 3);
	}
	
	public static String getFarbe() {
		return farbe;
	}
	
	public double getKantenlaenge() {
		return kantenlaenge;
	}
	
	public static void setFarbe(String pFarbe) {
		farbe = pFarbe;
	}
	
	public void setKantenlaenge(double pKantenlaenge) {
		if (pKantenlaenge >= 0) {
			kantenlaenge = pKantenlaenge;
		}
		else {
			kantenlaenge = -pKantenlaenge;
		}
	}
	
	public static void main(String[] args) {
		Wuerfel w = new Wuerfel(2.5);
		
		System.out.println(w.getKantenlaenge());
		w.setKantenlaenge(3.0);
		System.out.println(w.getKantenlaenge());
		System.out.println(w.berechneVolumen());
		
		Wuerfel.setFarbe("blau");
		System.out.println("\nAktuelle Farbe: " + Wuerfel.getFarbe());
	}

}
