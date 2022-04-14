import java.util.function.Function;

public class Integrate {

	public static double integrate(double left, double right, int steps, Function<Double, Double> f) {
		double delta = (right - left) / steps;
		double value = 0;
		
		for (int i = 0; i < steps; i++) {
			value = value + (f.apply(left + (i * delta)) * delta);
		}
		
		return value;
	}
	
	public static void main(String[] args) {
		System.out.println(integrate(-1, 1, 100, (x) -> {
			return (-2*x*x)+2;
		}));
		
		System.out.println(integrate(-1, 1, 100, new Function<Double,Double>()
		{
			public Double apply(Double t) {
				return (-2*t*t)+2;
			}
		}));
	}

}
