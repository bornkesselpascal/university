public abstract class Elektroprodukt implements Produkt {

	private int warennummer;
	private int preis;
	
	protected Elektroprodukt(int pWarennummer, int pPreis) {
		warennummer = pWarennummer;
		preis = pPreis;
	}
	
	public String getWarennummer() {
		return String.format("%6d", warennummer);
	}
	
	public int getPreis() {
		return preis;
	}
	
}
