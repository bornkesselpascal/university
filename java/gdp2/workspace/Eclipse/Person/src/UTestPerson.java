import static org.junit.Assert.*;

import org.junit.Test;

public class UTestPerson {

	@Test
	public void test_hatGeburtstag1() {
		Person persA = new Person("Frau", "Ingrid", "Alster", "16.03.1991");
		
		// Prüft, ob die beiden Ergebnisse gleich sind.
		assertEquals("Wrong date", persA.hatGeburtstag(), false);
	}
	
	@Test
	public void test_hatGeburtstag2() {
		Person persA = new Person("Frau", "Ingrid", "Alster", "29.09.1991");
		
		// Prüft, ob die beiden Ergebnisse gleich sind.
		assertEquals("Wrong month.", persA.hatGeburtstag(), false);
	}
	
	@Test
	public void test_hatGeburtstag3() {
		Person persA = new Person("Frau", "Ingrid", "Alster", "29.03.1991");
		
		// Prüft, ob die beiden Ergebnisse gleich sind.
		assertEquals("Correct date and month.", persA.hatGeburtstag(), true);
	}

}
