public class RechteckApp {

	public static void main(String[] args) {
		Rechteck r1 = new Rechteck (12.0, 4.0);
		Rechteck r2 = new Rechteck (5.0);
		
		System.out.println("Erster Durchlauf:");
		System.out.println("Rechteck r1:\n\tHöhe:\t" + r1.getHoehe() + "\n\tBreite:\t" + r1.getBreite());
		System.out.println("Rechteck r2:\n\tHöhe:\t" + r2.getHoehe() + "\n\tBreite:\t" + r2.getBreite());
		
		r2.setSeitenlaengen(r1);
		
		System.out.println("\nZweiter Durchlauf:");
		System.out.println("Rechteck r1:\n\tHöhe:\t" + r1.getHoehe() + "\n\tBreite:\t" + r1.getBreite());
		System.out.println("Rechteck r2:\n\tHöhe:\t" + r2.getHoehe() + "\n\tBreite:\t" + r2.getBreite());
	}

}
