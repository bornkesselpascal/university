import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

public class PersonMap {

	public static void main(String[] args) {
		
		Map<Integer,Person> permap = new HashMap<>();
		
		// Hinzufügen mit map.put()
		permap.put(815,  new Person("Herr", "Fidel", "Castro", "15.10.1990"));
		permap.put(816,  new Person("Herr", "Jennifer", "Castro", "15.10.1990"));
		permap.put(817,  new Person("Herr", "Fidel", "Castro", "15.10.1990"));
		permap.put(818,  new Person("Herr", "Fidel", "Castro", "15.10.1990"));
		
		// Durlaufen aller Keys mit einer for-Schleife
		for(Integer key : permap.keySet()) {
			// Abruf des Wertes mit map.get(Key)
			System.out.println(key + ";" + permap.get(key));
		}
		
		// Ist der Key nicht vorhanden, wird ein Nullpointer geliefert – Vorsicht bei der weiteren Verarbeitung, eventuell Prüfung erforderlich
		System.out.println(permap.get(819));
		
		// map.entrySet() liefert eine Menge an Entrys, die weiter verarbeitet werden können
		for(Entry<Integer, Person> entry: permap.entrySet()) {
			System.out.println(entry.getValue().getVorname());
			System.out.println(entry.getKey());
		}

	}
	
}
