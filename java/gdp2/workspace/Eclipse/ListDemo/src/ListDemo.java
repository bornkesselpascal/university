import java.util.Iterator;
import java.util.LinkedList;

public class ListDemo {

	public static void main(String[] args) {
		LinkedList<String> myList = new LinkedList<String>();
		
		// Hinzufügen bei Strings natürlich auch in der vereinfachten Form
		myList.add(new String("Hallo")); 
		myList.add("Welt");
		myList.add("und");
		myList.add("guten");
		myList.add("Morgen.");
		
		System.out.println(myList.size());
		System.out.println(myList.isEmpty());
		
		System.out.println(myList.get(1));
		
		for (String current : myList) {
			System.out.println(current.toUpperCase());
		}
		
		
		// Durchgehen durch die Liste mit einem Iterator
		
		Iterator<String> iter = myList.iterator();
		
		// iter.hasNext() gibt true zurück, wenn es ein nächstes Element gibt
		while (iter.hasNext()) {
			// iter.next() gibt das nächste Element der aus Liste (schaltet weiter)
			System.out.println(iter.next().toLowerCase());
		}
		
		
		Iterator<String> iter2 = myList.iterator();
		
		// iter.hasNext() gibt true zurück, wenn es ein nächstes Element gibt
		while (iter2.hasNext()) {
			if(iter2.next().contains("u")) {
				// iter.remove() löscht das aktuelle Element
				iter2.remove();
			}
		}
		
		
		for (String current : myList) {
			System.out.println(current.toUpperCase());
		}
		
		
		String s = new String("Welt");
		
		// myList.contains() funktioniert, da die String.equals(Object o) in der Klasse String implementiert ist
		System.out.println(myList.contains(s));
		System.out.println(myList.contains(new String("Morgen.")));

	}

}
