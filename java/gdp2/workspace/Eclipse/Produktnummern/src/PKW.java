public class PKW extends Fahrzeugprodukt{

	private static final int modellnummer = 120;
	private static int warennummer = 0;
	
	public PKW(int pPreis) {
		super(warennummer, pPreis);
		warennummer++;
	}
	
	public String getModellnummer() {
		return String.format("%3d", modellnummer);
	}
	
}
