import java.util.Map;
import studiplayer.basic.TagReader;

public class TaggedFile extends SampledFile {

	private String album;
	
	public TaggedFile() {
		super();
	}
	
	public TaggedFile(String s) {
		super(s);
		readAndStoreTags(getPathname());
	}
	
	public void readAndStoreTags(String path) {
		Map<String, Object> tag_map = TagReader.readTags(path);
		String[] keys = new String[] {"title", "author", "album", "duration"};
		String[] values = new String[3];
		long value_duration;
		
		for(int i = 0; i < 3; i++) {
			values[i] = (String) tag_map.get(keys[i]);
		}
		value_duration = (long) tag_map.get(keys[3]);
		
		if(!(values[0] == null ||values[0].isEmpty() || values[0].isBlank())) {
			title = values[0].trim();
		}
		if(!(values[1] == null || values[1].isEmpty() || values[1].isBlank())) {
			author = values[1].trim();
		}
		if(!(values[2] == null || values[2].isEmpty() || values[2].isBlank())) {
			album = values[2].trim();
		}
		else {
			album = "";
		}
		if(value_duration != 0 && value_duration > 0) {
			duration = value_duration;
		}
		else {
			duration = 0L;
		}
	}
	
	public String getAlbum() {
		if (!album.isEmpty()) {
			return album;
		}
		else {
			return "";
		}
	}
	
	public String toString() {
		if (getAlbum().equals("")) {
			return super.toString() + " - " + getFormattedDuration();
		}
		else {
			return super.toString() + " - " + getAlbum() + " - " +
					getFormattedDuration();
		}
	}
	
	public String[] fields() {
		String[] ret_array = new String[4];
		ret_array[0] = this.getAuthor();
		ret_array[1] = this.getTitle();
		ret_array[2] = this.getAlbum();
		ret_array[3] = this.getFormattedDuration();
		return ret_array;
	}
}
