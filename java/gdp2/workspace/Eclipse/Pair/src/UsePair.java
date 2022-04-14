import java.util.ArrayList;

public class UsePair {

	public static void main(String[] args) {
		
		// Erstellung einer ArrayList mit Pairs, die aus Integer bestehen (Type-Argumente nicht vergessen!)
		ArrayList<Pair<Integer, Integer>> myList = new ArrayList<>();
		
		// Hinzufügen der Paare.
		myList.add(new Pair<Integer, Integer>(1, 2));
		myList.add(new Pair<Integer, Integer>(1, 3));
		myList.add(new Pair<Integer, Integer>(2, 4));
		myList.add(new Pair<Integer, Integer>(2, 5));
		myList.add(new Pair<Integer, Integer>(5, 3));
		
		// Foreach-Schleife mit Pairs von Integern (Type-Argumente nicht vergessen!)
		for(Pair<Integer, Integer> myPair : myList) {
			System.out.println(myPair.getFirst() + " -> " + myPair.getSecond());
		}
	}

}
