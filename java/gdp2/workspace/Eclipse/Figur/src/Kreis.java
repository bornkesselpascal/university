public class Kreis implements Figur {

  // Kreis implementiert die Schnittstelle,
  // d.h. erbt von Figur

  private double radius;

  public Kreis(double radius) {
    setRadius(radius);
  }

  public double getRadius() {
    return radius;
  }

  public void setRadius(double radius) {
    this.radius = radius;
  }

  public double berechneUmfang() {
    return 2 * radius * Math.PI;
  }

  // Interface als Typ: Substitutierbarkeit gilt auch
  // f�r Interfaces

  public double addiereFlaeche(Figur f) {
    return this.berechneFlaeche() + f.berechneFlaeche();
  }

  // Methode muss implementiert werden

  public double berechneFlaeche() {
    return radius * radius * Math.PI;
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

