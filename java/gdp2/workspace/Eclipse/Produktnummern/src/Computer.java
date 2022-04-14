public class Computer extends Elektroprodukt{

	private static int warennummer = 0;
	private static final int  modellnummer = 20;
	
	public Computer(int pPreis) {
		super(warennummer, pPreis);
		warennummer++;
	}

	public String getModellnummer() {
		return String.format("%03x", modellnummer);
	}
	
}
