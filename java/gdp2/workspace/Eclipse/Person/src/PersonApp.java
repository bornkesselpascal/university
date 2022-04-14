public class PersonApp {

	public static void main(String[] args) {

		Person persA = new Person("Frau", "Ingrid", "Alster", "16.09.1991");

		// Println sucht automatisch nach der toString() Methode einer Klasse, dies kann daher weggelassen werden
		System.out.println(persA);
		
		System.out.println("Hat " + persA.getVorname() + " heute Geburtstag? " + persA.hatGeburtstag());
		
		Person persB = new Person("Frau", "Ingrid", "Alster", "16.09.1991");
		System.out.println("\nVergelich der Referenzen:\n\t" + (persA == persB));
		System.out.println("Vergelich mit \"equals\":\n\t" + (persA.equals(persB)));
		
		System.out.println("\nPersonenzahl: " + Person.getPersonenzahl() + "\n\n");
		
		
		Person[] gruppe = new Person[3];
		gruppe [0] = persA;
		gruppe [1] = persB;
		gruppe [2] = new Person("Herr", "Adalbert", "Alster", "01.02.1983");
		
		for (Person p:gruppe) {
			System.out.println(p.getVorname());
		}
		
		Mitarbeiter maA = new Mitarbeiter("Herr", "Josef", "Mustermann", "19.04.1999", "000001", 40000.0);
		System.out.println("\n\nMITARBEITER:\n" + maA + " mit ID " + maA.getId() + " und Gehalt " + maA.getGehalt());
		maA.erhoeheGehalt();
		System.out.println(maA + " mit ID " + maA.getId() + " und Gehalt " + maA.getGehalt());
		
		
		System.out.println("\n\nSTUDENT:");
		Person persC = new Person("Herr", "Max", "Mustermann", "03.06.1991");
		
		Student[] studis = new Student[3];
		studis[0] = new Student("Herr", "Karl", "Mustermann", "03.06.1991", "Matr1", "FFI");
		studis[1] = new Student("Herr", "Max", "Mustermann", "03.06.1991", "123456", "FFI");
		studis[2] = new Student("", "Max", "Mustermann", "03.06.1991", "789012", "BWL");
		
		for(int i = 0; i < studis.length; i++) {
			if(persC.equals(studis[i])) {
				System.out.println(studis[i].getStudiengang());
			}
		}
		
	}
}
