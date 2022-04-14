public class GirokontoApp {

	public static void main(String[] args) {
		Girokonto myKonto = new Girokonto("DE123456", 200);

		myKonto.zahleEin(2000);
		myKonto.zahleAus(500);
		
		myKonto.zahleAus(3000);
		
		System.out.println("Kontonummer:\t" + myKonto.getKontonummer() + "\nKontostand:\t" + myKonto.getKontostand() + "\nDispo:\t\t" + myKonto.getDispo());
	}

}
