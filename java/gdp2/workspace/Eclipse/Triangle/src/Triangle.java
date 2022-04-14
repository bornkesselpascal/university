public class Triangle {

	private Point nodes[] = new Point[3];
	
	public Triangle(Point p1, Point p2, Point p3) {
		nodes[0] = p1;
		nodes[1] = p2;
		nodes[2] = p3;
		
		if (nodes[0].equals(nodes[1]) || nodes[0].equals(nodes[2]) || nodes[1].equals(nodes[2])) {
			System.out.println("Diese Punkte stellen kein Dreieck dar!");
		}
	}
	
	public double circum() {
		double lenght = nodes[0].distance(nodes[1]) + nodes[1].distance(nodes[2]) + nodes[2].distance(nodes[0]); 
		return lenght;
	}
}
