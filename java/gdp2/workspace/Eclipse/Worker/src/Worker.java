import java.util.ArrayList;
import java.util.List;

public class Worker {
	// Worker erledigt Aufgaben, die sehr lange brauchen
	// Hauptprogramm soll aber nicht darauf warten
	
	// Liste von Klassen, die bescheid bekommen, wenn Funktion fertig
	private List<FinishedListener> registered = new ArrayList<>();
	
	public void register(FinishedListener listener) {
		registered.add(listener);
	}
	
	public void work(int i) {
		// Ist i das Produkt von zwei Primzahlen?
		// Neuer Thread gestartet, der Berechnung ausführt
		(new Thread() {
			public void run() {
				for (int k = 2; k < i; k++) {
					if (isPrime(k)) {
						for (int j = k; j < i; j++) {
							if(isPrime(j)) {
								//...
							}
						}
					}
				}
			for(FinishedListener listener : registered) {
				
			}
			}
		}).start();
	}
	
	private static boolean isPrime(int i) {
		// Kein richtiger Primzahlerkenner
		if (i % 2 == 0) {
			return true;
		}
		else {
			return false;
		}
	}
}
