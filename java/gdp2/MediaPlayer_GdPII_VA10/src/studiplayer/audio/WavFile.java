package studiplayer.audio;
import studiplayer.basic.WavParamReader;

public class WavFile extends SampledFile{

	public WavFile() {
		super();
	}
	
	public WavFile(String s) throws NotPlayableException {
		super(s);
		readAndSetDurationFromFile(getPathname());
	}
	
	public static long computeDuration(long numberOfFrames, float frameRate) {
		double duration = (((double) numberOfFrames)/frameRate * 1000000);
		return (long) duration;
	}
	
	public void readAndSetDurationFromFile(String pathname) throws NotPlayableException {
		try {
			WavParamReader.readParams(pathname);
			long numberOfFrames = WavParamReader.getNumberOfFrames();
			float frameRate = WavParamReader.getFrameRate();
			
			duration = WavFile.computeDuration(numberOfFrames, frameRate);
		}
		catch (RuntimeException e) {
			throw new NotPlayableException(pathname, e);
		}
	}
	
	public String toString() {
		return super.toString() + " - " + getFormattedDuration();
	}

	public String[] fields() {
		String[] ret_array = new String[4];
		ret_array[0] = this.getAuthor();
		ret_array[1] = this.getTitle();
		ret_array[2] = ""; // Kein Album bei Wav!
		ret_array[3] = this.getFormattedDuration();
		return ret_array;
	}
}
