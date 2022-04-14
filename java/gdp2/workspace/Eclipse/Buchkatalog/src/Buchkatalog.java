import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

public class Buchkatalog extends HashMap<String, Buch>{

	public Buchkatalog(String fileName) {
		BufferedReader reader = null;
		String line1 = null;
		String line2 = null;
		
		try {
			reader = new BufferedReader(new FileReader(fileName));
			while ((line1 = reader.readLine()) != null) {
				if ((line2 = reader.readLine()) != null) {
					Buch newBuch = new Buch(line2);
					put(line1, newBuch);
				}
			}
		}
		catch (IOException e) {
			System.err.printf("Fehler beim Lesen der Datei %s\n", fileName);
		}
		finally {
			try {
				reader.close();
			}
			catch(Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public Buch getBuch(String ISBN) {
		return get(ISBN);
	}
	
	public String getKatalog() {
		String result = "";
		Set<Map.Entry<String, Buch>> mySet = this.entrySet();
		Iterator<Entry<String, Buch>> myIter = mySet.iterator();
		
		while(myIter.hasNext()) {
			Entry<String, Buch> currentEntry = myIter.next();
			String currentKey = currentEntry.getKey();
			String currentValue = currentEntry.getValue().getTitel();
			result = result  + currentKey + ": " + currentValue + "; ";
		}
		
		return result;
	}
	
}
