import java.util.LinkedList;

public class EnumApp {

	public static void main(String[] args) {
		Weekday myDay = Weekday.MONTAG;
		
		// Methode myDay.name() gibt den Namen der Konstanten als String zurück. Die Methode toString() ruft standartmäßig name() auf.
		System.out.println(myDay.name());
		System.out.println(myDay.toString());
		
		// Methode myDay.ordinal() gibt den Zähler der Kontante (als Integer) zurück. Das erste Element in der Enumeration beginnt mit 0.
		System.out.println(myDay.ordinal());
		
		// Methode myDay.compareTo() (aus Comparable) vergleicht die Kontante mit einer anderen.
		Weekday myComp = Weekday.SAMSTAG;
		System.out.println(myDay.compareTo(myComp));
		System.out.println(myDay.compareTo(Weekday.FREITAG));
		System.out.println(myDay.compareTo(Weekday.MONTAG));
		System.out.println(myComp.compareTo(myDay));
		
		// Methode myDay.equals() gibt (als Boolean) zurück, ob das Objekt gleich der Enum-Kontanten ist.
		System.out.println(myDay.equals(Weekday.DONNERSTAG));
		System.out.println(myDay.equals(Weekday.MONTAG));
		System.out.println(myDay.equals(4));
		
		// Methode values() gibt ein Array mit den Konstanten zurück.
		Weekday[] myArray = Weekday.values();
		for (int i = 0; i < myArray.length; i++) {
			System.out.println(myArray[i]);
		}
			
		// Selbst erstellte Methode im Enum Weekday.
		System.out.println(myDay.isWeekend());
		System.out.println(myComp.isWeekend());	
	}

}
