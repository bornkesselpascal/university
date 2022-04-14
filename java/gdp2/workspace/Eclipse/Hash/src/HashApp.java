import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

public class HashApp {

	public static void main(String[] args) {

		System.out.println("HASHSET\n\nwhile-Schleife mit Iterator:");
		
		HashSet<String> hash1 = new HashSet<String>();
		
		hash1.add("Technische");
		hash1.add("Hochschule");
		hash1.add("Ingolstadt");
		hash1.add("Hochschule");
		
		Iterator<String> setIterator = hash1.iterator();
		while(setIterator.hasNext()) {
			System.out.println(setIterator.next());
		}
		
		System.out.println("\n\nfor-Schleife:");
		
		for(String myString: hash1) {
			System.out.println(myString);
		}
		
	
		
		System.out.println("\n\n\nHASHMAP\n\nwhile-Schleife mit Iterator:");

		Map<Integer, String> hash2 = new HashMap<>();
		
		hash2.put(1, "Technische");
		hash2.put(2, "Hochschule");
		hash2.put(3, "Ingolstadt");
		hash2.put(4, "Hochschule");
		
		Iterator<Entry<Integer, String>> mapIterator = hash2.entrySet().iterator();
		while(mapIterator.hasNext()) {
			System.out.println(mapIterator.next().getValue());
		}
		
		System.out.println("\n\nfor-Schleife:");
		
		for(Integer keys: hash2.keySet()) {
			System.out.println(hash2.get(keys));
		}
		
	}

}
