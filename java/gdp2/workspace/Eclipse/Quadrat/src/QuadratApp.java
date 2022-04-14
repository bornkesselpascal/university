
public class QuadratApp {

	public static void main(String[] args) {

		// Das ist eine lokale Variable vom Typ Quadrat.
		Quadrat q1;
		q1 = new Quadrat(2.0);
		
		// Das ist eine lokale Variable vom Typ double.
		double flVorher = q1.berechneFlaeche();
		q1.setSeitenLaenge(4.0);
		
		double flNacher = q1.berechneFlaeche();
		
		System.out.println("Flächendifferenz = " + (flNacher - flVorher));
	}
}
