public class Luhn {

	private String cardnumber;
	
	public Luhn(String pCardnumber) {
		cardnumber = pCardnumber;
	}
	
	public boolean check(int anz) {
		int i = cardnumber.length()-1;

		boolean duplicate = false;
		int digits = 0;
		int value = 0;
		
		for(int j = i; j >= 0; j--) {
			char current = cardnumber.charAt(j);
			
			if(Character.isDigit(current)){
				// Fall: Ziffer
				digits++;
				int currentValue = Character.digit(current, 10);
				System.out.printf("Current digit: " + currentValue + "\t");
				
				if(duplicate) {
					duplicate = false;
					currentValue = currentValue * 2;
					
					System.out.printf("Verdoppeln\t\t" + value + "\t");
					
					if(currentValue > 9) {
						// Quersumme von currentValue berechnen
						int sum = 0;
						
						while(currentValue >= 1) {
							sum = sum + (currentValue % 10);
							currentValue = currentValue / 10;
						}
						value = value + sum;
						
						System.out.printf("Queersumme\t" + sum + "\t" + value +"\n");
					}
					else {
						value = value + currentValue;
						System.out.printf("keine Queersumme\t" + value +"\n");
					}
				}
				else {
					duplicate = true;
					value = value + currentValue;
					System.out.printf("kein Verdoppeln\t\t\t\t\t\t" + value + "\n");
				}
			}
			else if(current == ' ') {
				// Fall: Leerzeichen
				
			}
			else {
				// Fall: Keine Zahl oder Leerziechen
				
				// Fehler: unerlaubte Zeichen
				System.err.println("unerlaubte Zeichen");
				return false;
			}
		}
		
		if(digits != anz) {
			// Fehler: falsche Anzahl
			System.err.println("falsche Anzahl: " + digits + " (count) != " + anz);
			return false;
		}
		
		if(value % 10 != 0) {
			// Fehler: Prüfsumme falsch
			System.err.println("Prüfsumme falsch: " + value + " % 10 != 0");
			return false;
		}
		
		return true;
	}
	
}
