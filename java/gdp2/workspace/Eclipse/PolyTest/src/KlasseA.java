public class KlasseA {

	public String meth() {
		return "Das ist meth der Klasse A.";
	}
	
	private String pmeth() {
		return "Das ist pmeth der Klasse A.";
	}
	
	public static void main(String args[]) {
		KlasseA x = new KlasseB();
		System.out.println(x.meth());
		System.out.println(x.pmeth());
	}
	
}
