package studiplayer.audio;

import java.util.Comparator;

public class AuthorComparator implements Comparator<AudioFile>{

	public int compare(AudioFile af1, AudioFile af2) {
		if ((af1 == null) || (af2 == null)) {
			// Einer der beiden AudioFile's ist ein Nullpointer -> Exception
			throw new NullPointerException("One AudioFile is a null-Pointer.");
		}
		
		String author1 = af1.getAuthor();
		String author2 = af2.getAuthor();
		
		if((author1 == null) && (author2 == null)) {
			// Author1 und Author2 sind Nullpointer, daher gleichwertig
			return 0;
		}
		else if (author1 == null) {
			// Author1 ist ein Nullpointer und damit kleiner als Author2
			// Vergleich von Author2 mit leeren String, um Ordnung beizubehalten
			return "".compareTo(author2);
		}
		else if (author2 == null) {
			// Author2 ist ein Nullpointer und damit kleiner als Author1
			// Vergleich von Author1 mit leeren String, um Ordnung beizubehalten
			return author1.compareTo("");
		}
		else {
			// normaler Fall (keine Nullpointer)
			return author1.compareTo(author2);
		}
	}
}
