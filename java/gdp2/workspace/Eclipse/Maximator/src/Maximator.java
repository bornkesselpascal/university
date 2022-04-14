import java.util.Comparator;
import java.util.List;

public class Maximator<T> {

	public Maximator() {
	}
	
	public T max(List<T> list, Comparator<T> comparator) {
		T maximum = list.get(0);
		for(T myElement:list) {
			if(comparator.compare(maximum, myElement) < 0) {
				maximum = myElement;
			}
		}
		return maximum;
	}
	
}
