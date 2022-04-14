public abstract class Fahrzeugprodukt implements Produkt {
	
	private int warennummer;
	private int preis;

	protected Fahrzeugprodukt(int warennummer, int preis) {
		this.warennummer = warennummer;
		this.preis = preis;
	}

	public String getWarennummer() {
		return String.format("%03d/%03d", warennummer / 1000, warennummer % 1000);
	}
	
	public String getProduktnummer() {
		return "F-" + Produkt.super.getProduktnummer();
	}

	public int getPreis() {
		return preis * 100;
	}
}