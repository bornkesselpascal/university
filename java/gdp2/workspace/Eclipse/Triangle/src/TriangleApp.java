public class TriangleApp {

	public static void main(String[] args) {
		Triangle tr = new Triangle(new Point(0,0), new Point(1,1), new Point(1,0));
		System.out.println(tr.circum());
	}
}
