package studiplayer.audio;

import java.util.Comparator;

public class DurationComparator implements Comparator<AudioFile>{

	public int compare(AudioFile af1, AudioFile af2) {
		if ((af1 == null) || (af2 == null)) {
			// Einer der beiden AudioFile's ist ein Nullpointer -> Exception
			throw new NullPointerException("A AudioFile is a null-Pointer.");
		}
		
		// Duration gespeichert in SampledFile, von der alle erben
		String dur1 = ((SampledFile) af1).getFormattedDuration();
		String dur2 = ((SampledFile) af2).getFormattedDuration();
		
		// Übergabe der Formatierten Durations mit Strings, diese können verglichen werden
		if((dur1 == null) && (dur2 == null)) {
			// 1 und 2 sind Nullpointer, daher gleichwertig
			return 0;
		}
		else if (dur1 == null) {
			// 1 ist ein Nullpointer und damit kleiner als 2
			// Vergleich von 2 mit leeren String, um Ordnung beizubehalten
			return "".compareTo(dur2);
		}
		else if (dur2 == null) {
			// 2 ist ein Nullpointer und damit kleiner als 1
			// Vergleich von 1 mit leeren String, um Ordnung beizubehalten
			return dur1.compareTo("");
		}
		else {
			// normaler Fall (keine Nullpointer)
			return dur1.compareTo(dur2);
		}
	}
	
}
