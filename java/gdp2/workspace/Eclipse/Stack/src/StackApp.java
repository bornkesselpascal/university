public class StackApp {

	public static void main(String[] args) {
		Stack<String> myStack = new Stack<>();
		
		myStack.push("Montag");
		myStack.push("Dienstag");
		myStack.push("Mittwoch");
		myStack.push("Donnerstag");
		myStack.push("Freitag");
		
		while(!(myStack.isEmpty())) {
			System.out.println(myStack.pop());
		}
	}

}
