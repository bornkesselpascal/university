public class Point {
	
	private static final double DELTA_VALUE = Math.pow(10, -7);
	private double x;
	private double y;
	
	public Point(double pX, double pY) {
		x = pX;
		y = pY;
	}

	public double getX() {
		return x;
	}

	public double getY() {
		return y;
	}
	
	public double distance(Point p) {
		return Math.sqrt(Math.pow((x-p.x), 2) + Math.pow((y-p.y), 2));
	}
	
	public boolean equals(Object p) {
		double dx = x - ((Point) p).x;
		double dy = y - ((Point) p).y;
		
		if (Math.abs(dx) > DELTA_VALUE || Math.abs(dy) > DELTA_VALUE) {
			return false;
		}
		else {
			return true;
		}
	}
}
