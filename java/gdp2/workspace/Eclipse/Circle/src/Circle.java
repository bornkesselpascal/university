public class Circle {

  private double cx;
  private double cy;
  
  private double radius;

  public Circle(double pCx, double pCy, double pRadius) {
    cx = pCx;
    cy = pCy;
    // We silently convert a negative radius to a positive one
    radius = Math.abs(pRadius);
  }

  public double computeArea() {
    return radius * radius * Math.PI;
  }

  public double computeDistanceOfCenters(Circle that) {
    return Math.sqrt((cx - that.cx) * (cx - that.cx)
                   + (cy - that.cy) * (cy - that.cy));
  }

  public boolean touches(Circle that) {
    return (computeDistanceOfCenters(that) <= radius + that.radius);
  }

  public static double computeDistanceOfCenters2(Circle c1, Circle c2) {
	  return Math.sqrt((c1.cx - c2.cx) * (c1.cx - c2.cx)
              + (c1.cy - c2.cy) * (c1.cy - c2.cy));
  }
}
