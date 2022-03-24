package studiplayer.audio;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.LinkedList;
import java.util.Scanner;

@SuppressWarnings("serial")
public class PlayList extends LinkedList<AudioFile> {

	private int current;
	private boolean randomOrder;
	
	public PlayList() {
		current = 0;
		randomOrder = false; 
	}
	
	public PlayList(String pathname) {
		this();
		loadFromM3U(pathname);
	}
	
	public void setCurrent(int pCurrent) {
		current = pCurrent;
	}
	
	public int getCurrent() {
		return current;
	}
	
	public AudioFile getCurrentAudioFile() {
		if (isEmpty()) {
			return null;
		}
		
		AudioFile af;
		
		try {
			af = get(current);
		}
		catch(java.lang.IndexOutOfBoundsException error) {
			return null;
		}
		
		return af;
	}

	public void changeCurrent () {
		int currentModifyer = current;
		
		if(current + 1 >= size()) {
			currentModifyer = 0;
			
			if (randomOrder) {
				Collections.shuffle(this);
			}
		}
		else {
			currentModifyer++;
		}
		
		try {
			get(current);
		}
		catch(java.lang.IndexOutOfBoundsException error) {
			currentModifyer = 0;
		}
		
		current = currentModifyer;
	}

	public void setRandomOrder(boolean pRandomOrder) {
		randomOrder = pRandomOrder;
		
		if (randomOrder) {
			Collections.shuffle(this);
		}
	}

	public void saveAsM3U(String pathname) {
		FileWriter writer = null;
		String linesep = System.getProperty("line.separator");
		
		try {
			writer = new FileWriter(pathname);
			AudioFile current = null;
			for (int i = 0; i < size(); i++) {
				try {
					current = get(i);
					writer.write(current.getPathname() + linesep);
				}
				catch(java.lang.IndexOutOfBoundsException error) {
					
				}
			}
			
			DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd hh:mm");
			writer.write(linesep + "# Pascal Julian Bornkessel" + 
					linesep + "# " + dtf.format(LocalDateTime.now()));
		}
		catch (IOException e){
			throw new RuntimeException("Unable to write to file." + pathname + e.getMessage());
		}
		finally {
			try {
				writer.close();
			}
			catch (Exception e) {
				
			}
		}
	}
	
	public void loadFromM3U(String pathname) {
		this.clear();
		
		Scanner scanner = null;
		String line;
		AudioFile af;
		
		try {
			scanner = new Scanner(new File(pathname));
			
			while(scanner.hasNext()) {
				line = scanner.nextLine();
				
				if (line.startsWith("#")) {
					// Ignorieren der Zeile, da Kommentar.
				}
				else if (line.isBlank()) {
					// Zeile ist leer.
				}
				else {	
					try {
						af = AudioFileFactory.getInstance(line);
						this.add(af);
					}
					catch (NotPlayableException e) {
						e.printStackTrace();
					}
				}
			}
		}
		catch(IOException e) {
			throw new RuntimeException(e);
		}
		finally {
			try {
				scanner.close();
			}
			catch(Exception e) {
			}
		}
		
		current = 0;
	}

	public void sort(SortCriterion order) {
		if(order.equals(SortCriterion.TITLE)) {
			Collections.sort(this, new TitleComparator());
		}
		
		if(order.equals(SortCriterion.ALBUM)) {
			Collections.sort(this, new AlbumComparator());
		}
		
		if(order.equals(SortCriterion.AUTHOR)) {
			Collections.sort(this, new AuthorComparator());
		}
		
		if(order.equals(SortCriterion.DURATION)) {
			Collections.sort(this, new DurationComparator());
		}
	}
}
