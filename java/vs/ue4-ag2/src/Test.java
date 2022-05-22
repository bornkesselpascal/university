import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class Test {

	public static void main(String[] args) throws IOException {
		UniqueId myObject = new UniqueId("id.dat");
		myObject.init(10000);
		
		
		class SyncThreads extends Thread {
			private int num;
			
		    public SyncThreads(int num) {
		        this.num = num;
		    }

		    @Override
		    public void run() {
		    	 System.out.println("Thread " + String.valueOf(num) + " wurde erzeugt.");
		    	 
		    	 for(int i = 0; i < 10; i++) {
		    		 try {
						int retVal = myObject.getNext();
						System.out.println("Thread " + String.valueOf(num) + ", Wert " + String.valueOf(retVal));
					} catch (IOException e) {
						e.printStackTrace();
					}
		    	 }
		    }
		}

		for(int i = 0; i < 5; i++) {
			SyncThreads myThread = new SyncThreads(i);
			myThread.start();
		}
	}
}
