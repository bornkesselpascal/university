import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

public class FileCreator {

	public static void main(String[] args) {
		BufferedWriter write = null;
		long size = 5000 * 1024 * 1024;
		
		try {
			write = new BufferedWriter(new FileWriter("/Users/bornkessel/Desktop/file3.txt"));
			
			for(long i = 0; i < size; i++) {
				write.write(" ");
				
				if(i% 100000 == 0) {
					System.out.println("Still working...");
				}
			}
		}
		catch (IOException e) {
			System.err.print("Fehler");
			e.printStackTrace();
		}
		finally {
			try {
				write.close();
			}
			catch (Exception e) {
				
			}
		}
		
	}
	
}
