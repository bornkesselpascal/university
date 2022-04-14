public class CircleApp {

  public static void main(String[ ] args) {
    Circle c1 = new Circle(4.0, 2.0, 0.9);
    Circle c2 = new Circle(-1.0, 2.0, 1.2);

    System.out.println("Area of c1: " + c1.computeArea());
    System.out.println("Area of c2: " + c2.computeArea());
    System.out.println("Distance: " + c1.computeDistanceOfCenters(c2));
    System.out.println("Touches: " + c1.touches(c2));
    
    System.out.println("\nNew Distance: " + Circle.computeDistanceOfCenters2(c1, c2));
  }

}
