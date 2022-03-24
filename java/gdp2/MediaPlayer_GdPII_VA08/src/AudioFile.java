import java.io.File;

public abstract class AudioFile {

	private String pathname;
	private String filename;
	protected String author;
	protected String title;
	
	public AudioFile() {
	}
	
	public AudioFile(String s) {
		parsePathname(s);
		parseFilename(getFilename());
		
		File testFile = new File(getPathname());
		if(!testFile.canRead()) {
			throw new RuntimeException("Path unreadable. - " + getPathname());
		}
	}
	
	public void parsePathname(String s) {
		char separatorChar = System.getProperty("file.separator").charAt(0);
		String path = "";
		String file = "";
		int startpoint = 0;
		boolean sep = false;
		boolean linux = false;
		
		if(separatorChar == '/') {
			linux = true;
		}
		
		if(s.isEmpty()) {
			path = "";
			file = "";
		}
		else if (!(s.contains("/") || s.contains("\\"))) {
			path = s;
			file = s;
		}
		else {
			
			// Laufwerksbuchstabe ist zu Beginn angegeben
			if(!(s.charAt(0) == '/' || s.charAt(0) == '\\')) {
				
				int seploc = 0;
				int sep1loc = s.indexOf('\\');
				int sep2loc = s.indexOf('/');
				
				if (sep1loc != -1 && sep2loc != -1) {
					if (sep1loc < sep2loc) {
						seploc = sep1loc;
					}
					else {
						seploc = sep2loc;
					}
				}
				else if (sep2loc == -1){
					seploc = sep1loc;
				}
				else {
					seploc = sep2loc;
				}
				
				String check = s.substring(0, seploc);
				
				if(check.contains(":")) {
					startpoint = seploc+1;
					sep = true;
					
					if(linux) {
						
						path = path + separatorChar;
						for (int j = 0; j < seploc; j++) {
							if (Character.isLetter(s.charAt(j))) {
								path = path + s.charAt(j);
							}
						}
						path = path + separatorChar;
					}
					else {
						
						for (int j = 0; j < seploc; j++) {
								path = path + s.charAt(j);
						}
						path = path + separatorChar;
					}	
				}
				
			}
			
			
			// Formatieren des Pfades
			for (int i = startpoint; i < s.length(); i++) {
				char currentChar = s.charAt(i);
				
				if (currentChar == '/' || currentChar == '\\') {
					
					if (!sep) {
						path = path + separatorChar;
					}
					
					sep = true;
				}
				else {
					sep = false;
					path = path + currentChar;
				}
			}
		}
		
		int y = path.lastIndexOf(separatorChar);
		file = path.substring(y+1);
		
		pathname = path;
		filename = file;
	}
	
	public String getPathname() {	
		return pathname;
	}
	
	public String getFilename() {
		return filename;
	}
	
	public void parseFilename(String s) {
		String parsedAuthor = "";
		String parsedTitle = "";
		String file = s;
		boolean firstIter = true;
		
		int point = s.lastIndexOf('.');
		
		if (point >= 0) {
			file = s.substring(0, point);
		}
		
		String[] splitStr= file.split(" - ");
		int lenght = splitStr.length;
		
		if (lenght == 1) {
			parsedAuthor = "";
			parsedTitle = splitStr[0].trim();
		}
		else if (lenght == 2) {
			parsedAuthor = splitStr[0].trim();
			parsedTitle = splitStr[1].trim();
		}
		else if (lenght > 2) {
			// Neue Bedingung: Es sind mehr Trennzeichen enthalten
			// Der erste Abschnitt ist der Autor
			// Alle weiteren Abschnitte gehören zum Titel
			
			parsedAuthor = splitStr[0].trim();
			
			for (int l = 1; l < lenght; l++) {
				
				if (firstIter) {
					parsedTitle = splitStr[l].trim();
					firstIter = false;
				}
				else {
					parsedTitle = parsedTitle + " - " + splitStr[l].trim();
				}
			}
		}
		else {
			parsedAuthor = "";
			parsedTitle = "";
		}

		author = parsedAuthor;
		title = parsedTitle;
	}
	
	public String getAuthor() {
		return author;
	}
	
	public String getTitle() {
		return title;
	}

	public String toString() {
		String output = "";
		
		if (getAuthor().equals("")) {
			output = getTitle();
		}
		else {
			output = getAuthor() + " - " + getTitle();
		}
		
		return output;
	}
	
	public abstract void play();
	
	public abstract void togglePause();
	
	public abstract void stop();
	
	public abstract String getFormattedDuration();
	
	public abstract String getFormattedPosition();
	
	public abstract String[] fields();
}
