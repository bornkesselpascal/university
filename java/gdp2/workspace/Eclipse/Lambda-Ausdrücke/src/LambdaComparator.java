import java.util.Comparator;

public class LambdaComparator implements Comparator<Integer>{

	public int compare(Integer o1, Integer o2) {
		return o1.intValue() - o2.intValue();
	}
	
}
