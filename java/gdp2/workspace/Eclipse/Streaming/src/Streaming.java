import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.LinkedList;
import java.util.stream.Stream;

public class Streaming {

    public static void main(String[] args) throws IOException {
        ShortPData p1 = new ShortPData("Duck", "Pam", new GregorianCalendar(1925, 04, 01));
        ShortPData p2 = new ShortPData("Castro", "Fidel", new GregorianCalendar(1900, 10, 15));
        ShortPData p3 = new ShortPData("Castro", "Enrique", new GregorianCalendar(2002, 2, 31));
        ShortPData p4 = new ShortPData("Lopez", "Jennifer", new GregorianCalendar(1962, 9, 9));
        ShortPData p5 = new ShortPData("Duck", "Donald", new GregorianCalendar(1923, 04, 01));
        ShortPData p6 = new ShortPData("Alster", "Ingrid", new GregorianCalendar(1962, 9, 9));

        LinkedList<ShortPData> plist = new LinkedList<>();
        plist.add(p1);
        plist.add(p2);
        plist.add(p3);
        plist.add(p4);
        plist.add(p5);
        plist.add(p6);

        // AUFGABE: Welche Personen sind älter als 60 Jahre?
        
        // Klassisches Handling einer Datenstruktur mit einer Schleife
        //		- Schleifenprogrammierung erforderlich
        //		- Laufzeitaufwändig
        for (ShortPData p: plist)
            if (p.getGebdatum().before(new GregorianCalendar(1960, 05, 24)))
                System.out.println(p);
        System.out.println();
        
        
        // Streams (deklarative Programmierung, Was soll bewirkt werden?)
        plist.stream()
        	// Angabe des Kriteriums, nach dem gefiltert werden soll
        	.filter(p -> {
        		return p.getGebdatum().before(new GregorianCalendar(1960, 05, 24));
        	})
        	// Sortieren mit Comparator
        	.sorted((a,b) -> {
        		return a.getGebdatum().compareTo(b.getGebdatum());
        	})
        	// Anschauen des Objekts
        	.peek(p -> System.out.println(p.getName()))
        	// Mappen auf das Geburtsdatum, ShortPData durch Geburtsdatum ersetzt
        	.map(p -> p.getGebdatum())
        	// mit jedem Element, das übrig geblieben ist etwas machen (z.B. Ausgabe)
        	.forEach(p -> {System.out.println(p.get(Calendar.DAY_OF_MONTH));
        		
        	});
        
        
        
        

        /*
        plist.stream()
             .filter(p -> p.getGebdatum().before(new GregorianCalendar(1960, 05, 24)))
             .sorted((p, q) -> p.getGebdatum().compareTo(q.getGebdatum()))
             .forEach(System.out::println);
        System.out.println();

        Stream.of(p1, p2, p3, p4, p5, p6)
              .filter(p -> p.getGebdatum().before(new GregorianCalendar(1960, 05, 24)))
              .sorted((p, q) -> p.getGebdatum().compareTo(q.getGebdatum()))
              .map(p -> p.getGebdatum())
              .limit(2)
              .forEach(g -> System.out.println(g.get(Calendar.YEAR) + "/" + g.get(Calendar.MONTH) + "/" + g.get(Calendar.DATE)));
        System.out.println();
        */
    }

}
