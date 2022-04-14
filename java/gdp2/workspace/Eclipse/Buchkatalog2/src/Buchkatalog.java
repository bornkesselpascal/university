import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;

public class Buchkatalog extends HashMap<String,Buch> {

  public Buchkatalog(String fileName) throws FileNotFoundException, IOException {
    BufferedReader reader = null;
    String line1 = null; 
    String line2 = null; 

    reader = new BufferedReader(new FileReader(fileName));

    while ((line1 = reader.readLine()) != null) {
      if ((line2 = reader.readLine()) != null) {
        Buch newBuch = new Buch(line2);
        put(line1, newBuch);
      }
    }

    reader.close(); 
  }

  public Buch getBuch(String nummer) {
    return (Buch) get(nummer);
  }

  public String getKatalog() {
    Iterator<Entry<String,Buch>> iterator = entrySet().iterator();
    String content = new String();

    while (iterator.hasNext()) {
      Entry<String,Buch> entry = (Entry<String,Buch>) iterator.next();

      content += entry.getKey() + ": " 
                 + entry.getValue().getTitel() + "\n";
    }

    return content;
  }

  public static void main(String[] args) {
    Buchkatalog buecher = null;

    try {
      buecher = new Buchkatalog("src/buchkatalog.txt");
    }
    catch (FileNotFoundException e) {
      System.err.printf("Fehler beim Oeffnen der Datei src\\buchkatalog.txt\n");
    }
    catch (IOException e) {
      System.err.printf("Fehler beim Lesen der Datei src\\buchkatalog.txt\n");
    }

    Buch b;

    if ((b = buecher.getBuch("978-3836228732")) != null)
      System.out.println(b.getTitel());

    if ((b = buecher.getBuch("xxxxxxxxxxxxxx")) != null)
      System.out.println(b.getTitel());

    System.out.println();
    System.out.println(buecher.getKatalog());    
  }

}
