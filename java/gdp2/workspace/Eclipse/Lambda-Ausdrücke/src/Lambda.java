import java.util.Arrays;
import java.util.Comparator;

public class Lambda {

	public static void main(String[] args) {
		
		System.out.println("\n\n\nAusgangssituation:");
		Integer[] myArray = new Integer[] {
				1, 2, 43, 45, 52, 64, 9, -4, 0, 948
		};
		Integer[] mySort = myArray.clone();
		Lambda.print(mySort);
		
		// Machmal ist es praktisch, eine Funktion als Parameter zu übergeben, zum Beispiel beim Sortieren von Arrays
		// mit Arrays.sort(Array[], Comparator) muss ein Comparator übergeben werden, der die Sortierung der Elemente
		// bestimmt.
		
		// Klassischerweise wurde ein Interface mit einer entsprechenden Methode definiert (zum Beispiel das vordefinierte
		// Interface Comarator), eine Klasse erstellt, die dieses Interface implementiert (hier die Klasse LambdaComparator)
		// und ein neues Objekt dieser Klasse übergeben (wie im Praktikum VA09).
		
		System.out.println("\n\n\nComparator:");
		LambdaComparator myComp = new LambdaComparator();
		Arrays.sort(mySort, myComp);
		Lambda.print(mySort);
		mySort = myArray.clone();
		
		// KLAMMERN HINTER NEW COMPARATOR BEACHTEN!!! - KONSTRUKTOR
		System.out.println("\n\n\nComparator direkt implementiert:");
		Arrays.sort(mySort, new Comparator<Integer>() {
			public int compare(Integer o1, Integer o2) {
				return o1-o2;
			}
		});
		Lambda.print(mySort);
		mySort = myArray.clone();
		
		// Seit Java 8 kann eine Funktion als Referenz übergeben werden. Die Methode kann eine statische oder nicht-statische
		// Methode sein.
		
		System.out.println("\n\n\nFunktion als Referenz:");
		Arrays.sort(mySort, Integer::compareTo);
		Lambda.print(mySort);
		mySort = myArray.clone();
		
		// Noch einfacher geht es in Java mit den Lambda-Ausdrücken. Lamda-Ausdrücke sind auch für selbstdefinierte Funktionen
		// möglich. 
		// Ein Lamda-Ausdruck entspricht einer Zuordnung x -> f(x) und besteht im allgemeinen aus
		//		- Parametern ((Typ1) name1, (Typ2) name2,…) und mit den Parametern arbeitender
		//		- Ausdruck, der etwas zurückgibt oder {Anweisungen}, die zwingend return enthalten müssen
		
		System.out.println("\n\n\nLambda-Ausdruck:");
		Arrays.sort(mySort, (a,b) -> a.compareTo(b));
		Lambda.print(mySort);
		mySort = myArray.clone();
		
		System.out.println("\n\n\nLambda-Ausdruck mit Anweisungen:");
		Arrays.sort(mySort, (a,b) -> {
			if (a % 2 != 0) {
				return a - b;
			}
			else {
				return Math.abs(a) - Math.abs(b);
			}
		});
		Lambda.print(mySort);
		mySort = myArray.clone();
		
	}
	
	public static void print(Integer[] myArray) {
		String printString = "";
		for (Integer myInt : myArray) {
			printString = printString + myInt.intValue() + ", ";
		}
		
		System.out.println(printString);
		
	}

}
