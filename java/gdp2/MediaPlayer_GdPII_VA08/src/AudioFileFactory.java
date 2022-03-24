public class AudioFileFactory {
	
	public static AudioFile getInstance(String pathname) {
		String fileType = pathname.substring((pathname.lastIndexOf(".")));
		AudioFile af = null;
		
		// Behandlung des Falles, dass kein Punkt im Pfad enthalten ist
		if(pathname.lastIndexOf(".") == -1) {
			throw new RuntimeException("AudioFile without suffix: \"" + pathname + "\"");
		}
		
		if ((fileType.toLowerCase()).equals(".wav")) {
			af = new WavFile(pathname);
		}
		else if (((fileType.toLowerCase()).equals(".ogg")) || ((fileType.toLowerCase()).equals(".mp3"))) {
			af = new TaggedFile(pathname);
		}
		else {
			throw new RuntimeException("Unknown suffix for AudioFile: \"" + pathname + "\"");
		}
		
		return af;
	}
	
}