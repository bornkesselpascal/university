import java.util.LinkedList;

public class Stack {

	private LinkedList<String> myStack;
	
	public Stack() {
		myStack = new LinkedList<String>();
	}
	
	public void push(String element) {
		myStack.add(element);
	}
	
	public String pop() {
		return myStack.remove(myStack.size()-1);
	}
	
	public boolean isEmpty() {
		return myStack.isEmpty();
	}
	
}
