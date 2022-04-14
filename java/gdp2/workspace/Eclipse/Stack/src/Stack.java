import java.util.LinkedList;

public class Stack<T> {

	private LinkedList<T> myStack;
	
	public Stack() {
		myStack = new LinkedList<T>();
	}
	
	public void push(T element) {
		myStack.add(element);
	}
	
	public T pop() {
		return myStack.remove(myStack.size()-1);
	}
	
	public boolean isEmpty() {
		return myStack.isEmpty();
	}
	
}
