public class UseFigur {

  public static void main(String[] args) {
    Figur f1 = new Kreis(1.0);
    Figur f2 = new Quadrat(2.0);

    // flaeche kann für alle abgeleiteten Klassen
    // verwendet werden
    System.out.printf("Flaeche von %s   = %6.2f\n", 
                      f1.getClass().getName(), f1.berechneFlaeche());

    System.out.printf("Flaeche von %s = %6.2f\n", 
                      f2.getClass().getName(), f2.berechneFlaeche());

    // Warum geht das nicht?
    //System.out.printf("Umfang von %s = %6.2f\n", 
    //                  f1.getClass().getName(), f1.berechneUmfang());

    Kreis k = (Kreis) f1;

    System.out.printf("Umfang von %s    = %6.2f\n", 
                      f1.getClass().getName(), k.berechneUmfang());
    
    
    System.out.println(f1.compareTo(k));
  }

}
