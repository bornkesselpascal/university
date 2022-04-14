import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedList;
import java.util.List;

public class MaximatorApp {

	public static void main(String[] args) {
		List<Integer> list = new LinkedList<Integer>();
		list.add(-2);
		list.add(155);
		list.add(98);
		list.add(155);
		
		System.out.println(Collections.max(list, (a,b) -> (queersumme(a) - queersumme(b))));
		
		Maximator<Integer> maxi = new Maximator<>();
		System.out.println(maxi.max(list, (a,b) -> (queersumme(a) - queersumme(b))));
		
		System.out.println(maxi.max(list, new Comparator<Integer>() {
			public int compare(Integer i1, Integer i2) {
				return queersumme(i1) - queersumme(i2);
			}
		}));
	}
	
	public static int queersumme(int zahl) {
		int summe = 0;
		while(0 != zahl) {
			summe = zahl % 10;
			zahl = zahl / 10;
		}
		return summe;
	}

}
