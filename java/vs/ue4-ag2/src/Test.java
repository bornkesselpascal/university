import java.io.DataOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;

public class Test {

	public static void main(String[] args) {
		
		try {
			DataOutputStream out = new DataOutputStream(new FileOutputStream("id.dat"));
			out.writeInt(10000);
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		
	}

}
