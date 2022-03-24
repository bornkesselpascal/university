package studiplayer.audio;

import java.util.Comparator;

public class TitleComparator implements Comparator<AudioFile>{

	public int compare(AudioFile af1, AudioFile af2) {
		if ((af1 == null) || (af2 == null)) {
			// Einer der beiden AudioFile's ist ein Nullpointer -> Exception
			throw new NullPointerException("One AudioFile is a null-Pointer.");
		}
		
		String title1 = af1.getTitle();
		String title2 = af2.getTitle();
		
		if((title1 == null) && (title2 == null)) {
			// Title1 und Title2 sind Nullpointer, daher gleichwertig
			return 0;
		}
		else if (title1 == null) {
			// Title1 ist ein Nullpointer und damit kleiner als Title2
			// Vergleich von Title2 mit leeren String, um Ordnung beizubehalten
			return "".compareTo(title2);
		}
		else if (title2 == null) {
			// Title2 ist ein Nullpointer und damit kleiner als Title1
			// Vergleich von Title1 mit leeren String, um Ordnung beizubehalten
			return title1.compareTo("");
		}
		else {
			// normaler Fall (keine Nullpointer)
			return title1.compareTo(title2);
		}
	}
}

