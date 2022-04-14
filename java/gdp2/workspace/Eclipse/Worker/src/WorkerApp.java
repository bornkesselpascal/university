
public class WorkerApp implements FinishedListener{

	// Beispiel zum OBSERVER-PATTERN
	
	public static void main(String[] args) {
		WorkerApp user = new WorkerApp();
		Worker myWorker = new Worker();
		myWorker.register(user);
		myWorker.work(199*211);
		
		
		
		
	}

	@Override
	public void handle(int i) {
		System.out.println("ERHALTEN" + i);
		
	}

}
