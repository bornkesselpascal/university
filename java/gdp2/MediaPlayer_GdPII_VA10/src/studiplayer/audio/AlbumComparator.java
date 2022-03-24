package studiplayer.audio;

import java.util.Comparator;

public class AlbumComparator  implements Comparator<AudioFile> {

	public int compare(AudioFile af1, AudioFile af2) {
		if ((af1 == null) || (af2 == null)) {
			// Einer der beiden AudioFile's ist ein Nullpointer -> Exception
			throw new NullPointerException("One AudioFile is a null-Pointer.");
		}
		
		// Feststellung, welche Klassen zu TaggedFile gehören und damit das Attibut besitzen
		boolean type1 = af1 instanceof  TaggedFile;
		boolean type2 = af2 instanceof TaggedFile;
		
		if (!type1 && !type2) {
			// Keines der Objekte vom benötigten Typ
			return 0;
		}
		else if(!type1) {
			// Erstes Objekt ist nicht vom benötigten Typ
			return -1;
		}
		else if(!type2) {
			// Zweites Objekt nicht vom benötigten Typ
			return 1;
		}
		else {
			// Beide Objekte sind vom benötigten Typ, Vergleich wird durchgeführt
			
			String album1 = ((TaggedFile) af1).getAlbum();
			String album2 = ((TaggedFile) af2).getAlbum();
			
			if((album1 == null) && (album2 == null)) {
				// Album1 und Album2 sind Nullpointer, daher gleichwertig
				return 0;
			}
			else if (album1 == null) {
				// Album1 ist ein Nullpointer und damit kleiner als Album2
				// Vergleich von Album2 mit leeren String, um Ordnung beizubehalten
				return "".compareTo(album2);
			}
			else if (album2 == null) {
				// Album2 ist ein Nullpointer und damit kleiner als Album1
				// Vergleich von Album1 mit leeren String, um Ordnung beizubehalten
				return album1.compareTo("");
			}
			else {
				// normaler Fall (keine Nullpointer)
				return album1.compareTo(album2);
			}
		}
	}
}
