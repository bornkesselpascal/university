public interface Produkt {

	public String getModellnummer();
	
	public String getWarennummer();
	
	public default String getProduktnummer() {
		return getModellnummer() + "." + getWarennummer();
	}
	
	public int getPreis();
}
