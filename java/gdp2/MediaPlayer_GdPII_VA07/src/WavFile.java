import studiplayer.basic.WavParamReader;

public class WavFile extends SampledFile{

	public WavFile() {
		super();
	}
	
	public WavFile(String s) {
		super(s);
		readAndSetDurationFromFile(getPathname());
	}
	
	public static long computeDuration(long numberOfFrames, float frameRate) {
		double duration = (((double) numberOfFrames)/frameRate * 1000000);
		return (long) duration;
	}
	
	public void readAndSetDurationFromFile(String pathname) {
		WavParamReader.readParams(pathname);
		long numberOfFrames = WavParamReader.getNumberOfFrames();
		float frameRate = WavParamReader.getFrameRate();
		
		duration = WavFile.computeDuration(numberOfFrames, frameRate);
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
