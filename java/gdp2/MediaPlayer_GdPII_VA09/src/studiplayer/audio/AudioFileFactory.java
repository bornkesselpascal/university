package studiplayer.audio;
public class AudioFileFactory {
	
	public static AudioFile getInstance(String pathname) throws NotPlayableException {
		
		// Behandlung des Falles, dass kein Punkt im Pfad enthalten ist
		// Werfen einer NotPlayableException
		if(pathname.lastIndexOf(".") == -1) {
			throw new NotPlayableException(pathname, "AudioFile without suffix.");
		}
		
		String fileType = pathname.substring((pathname.lastIndexOf(".")));
		AudioFile af = null;
		
		if ((fileType.toLowerCase()).equals(".wav")) {
			af = new WavFile(pathname);
		}
		else if (((fileType.toLowerCase()).equals(".ogg")) || ((fileType.toLowerCase()).equals(".mp3"))) {
			af = new TaggedFile(pathname);
		}
		else {
			throw new NotPlayableException(pathname, "Unknown suffix for AudioFile.");
		}
		
		return af;
	}
	
}