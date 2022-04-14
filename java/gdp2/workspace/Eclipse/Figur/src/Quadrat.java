public class Quadrat implements Figur {

  private double seitenLaenge;

  public Quadrat(double seitenLaenge) {
    setSeitenLaenge(seitenLaenge);
  }

  public double getSeitenLaenge() {
    return seitenLaenge;
  }

  public void setSeitenLaenge(double seitenLaenge) {
    this.seitenLaenge = seitenLaenge;
  }

  public double berechneUmfang() {
    return 4 * seitenLaenge;
  }

  public double addiereFlaeche(Figur f) {
    return this.berechneFlaeche() + f.berechneFlaeche();
  }

  public double berechneFlaeche() {
    return seitenLaenge * seitenLaenge;
  }
  
  public int compareTo(Object other) {
	  
	  if (this.berechneFlaeche() < ((Figur) other).berechneFlaeche()) {
		  return -1;
	  }
	  else if (this.berechneFlaeche() == ((Figur) other).berechneFlaeche()) {
		  return 0;
	  }
	  else {
		  return 1;
	  }
  }

}
