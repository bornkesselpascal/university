
public class Pair<T1,T2> {
	
	private T1 first;
	private T2 second;
	
	public Pair(T1 pFirst, T2 pSecond) {
		setFirst(pFirst);
		setSecond(pSecond);
	}
	
	public T1 getFirst() {
		return first;
	}
	
	public T2 getSecond() {
		return second;
	}
	
	public void setFirst(T1 pFirst) {
		first = pFirst;
	}
	
	public void setSecond(T2 pSecond) {
		second = pSecond;
	}

}
