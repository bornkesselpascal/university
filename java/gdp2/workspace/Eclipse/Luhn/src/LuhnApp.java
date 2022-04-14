public class LuhnApp {

	public static void main(String[] args) {

		Luhn example = new Luhn("4683 4578 2931 6528");
		boolean result = example.check(16);

		System.out.println("Gültige Kartennummer: " + result);
	}

}
