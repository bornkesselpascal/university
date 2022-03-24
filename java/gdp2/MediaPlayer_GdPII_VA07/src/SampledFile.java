import studiplayer.basic.BasicPlayer;

public abstract class SampledFile extends AudioFile{
	
	protected long duration;
	
	public SampledFile() {
		super();
	}
	
	public SampledFile(String s) {
		super(s);
	}
	

	public void play() {
		BasicPlayer.play(getPathname());
	}

	public void togglePause() {
		BasicPlayer.togglePause();
	}

	public void stop() {
		BasicPlayer.stop();
	}

	public String getFormattedDuration() {
		return SampledFile.timeFormatter(duration);
	}

	public String getFormattedPosition() {
		long position = studiplayer.basic.BasicPlayer.getPosition();
		return SampledFile.timeFormatter(position);
	}
	
	public static String timeFormatter(long microtime) {
		if(microtime < 0) {
			throw new RuntimeException("Negativ time value provided.");
		}
		if(microtime >= 6000000000L) {
			// 99:59 (mmss) ist die höchste Zeit, die angezeigt werden kann.
			throw new RuntimeException("Time value exceeds allowed format.");
		}
		
		long milliseconds = microtime / 1000;
		long seconds	  = milliseconds / 1000;
		long minutes      = seconds / 60;
		long restseconds  = seconds % 60;
		
		String ret_minutes = Long.toString(minutes);
		String ret_seconds = Long.toString(restseconds);
		
		if(ret_minutes.length() < 2) {
			ret_minutes = "0" + ret_minutes;
		}
		if(ret_seconds.length() < 2) {
			ret_seconds = "0" + ret_seconds;
		}
		
		return ret_minutes + ":" + ret_seconds;
	}
	
}
