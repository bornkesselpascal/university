public class BuchApp {

	public static void main(String[] args) {
		
		Buchkatalog myLib = new Buchkatalog("files/demo.txt");
		
		System.out.println(myLib.getBuch("1234").getTitel());
		System.out.println(myLib.getKatalog());
		
	}
	
}
