import static org.junit.Assert.*;

import java.util.Map;
import org.junit.Ignore;
import org.junit.Test;
import studiplayer.basic.TagReader;

public class UTestTaggedFile {

	@Test @Ignore
	public void test_play_01() throws Exception {
		TaggedFile tf = new TaggedFile("audiofiles/Rock 812.mp3");
		tf.play();
		
		// Note: Cancel playback in eclipse console window.
	}
	
	@Test @Ignore
	public void test_play_02() throws Exception {
		TaggedFile tf = new TaggedFile("audiofiles/Eisbach Deep Snow.ogg");
		tf.play();
		
		// Note: Cancel playback in eclipse console window.
	}
	
	@Test @Ignore
	public void test_play_03() throws Exception {
		TaggedFile tf = new TaggedFile("audiofiles/Mozart - Piano Concerto No25 Motiv.ogg");
		tf.play();
		
		// Note: Cancel playback in eclipse console window.
	}
	
	@Test @Ignore
	public void test_timeForamtter_01() throws Exception {
		assertEquals("Wrong time format", "05:05",
				TaggedFile.timeFormatter(305892000L));
	}
	
	@Test @Ignore
	public void test_timeForamtter_02() throws Exception {
		assertEquals("Wrong time format", "00:00",
				TaggedFile.timeFormatter(0L));
	}
	
	@Test @Ignore
	public void test_timeForamtter_03() throws Exception {
		try {
			TaggedFile.timeFormatter(-1L);
			fail("Erwartet.");
		}
		catch (RuntimeException e) {
			// Erwartet
		}
	}
	
	@Test @Ignore
	public void test_timeForamtter_04() throws Exception {
		try {
			TaggedFile.timeFormatter(3599900000L);
			fail("Erwartet.");
		}
		catch (RuntimeException e) {
			// Erwartet
		}
	}
	
	@Test @Ignore
	public void test_timeForamtter_05() throws Exception {
		assertEquals("Wrong time format", "59:59",
				TaggedFile.timeFormatter(3599000000L));
	}
	
	@Test @Ignore
	public void test_timeForamtter_06() throws Exception {
		assertEquals("Wrong time format", "03:05",
				TaggedFile.timeFormatter(185000000L));
	}
	
	@Test @Ignore
	public void test_readTags_01() throws Exception {
		TaggedFile tf = new TaggedFile("audiofiles/Rock 812.mp3");
		Map<String, Object> tag_map = TagReader.readTags(tf.getPathname());
		for (String key : tag_map.keySet()) {
			System.out.println("\nKey:\t\t" + key);
			System.out.println("Type of value:\t" + tag_map.get(key).getClass().toString());
			System.out.println("Value:\t\t" + tag_map.get(key));
		}
	}
	
	@Test @Ignore
	public void test_readTags_02() throws Exception {
		TaggedFile tf = new TaggedFile();
		tf.readAndStoreTags("audiofiles/Rock 812.mp3");
		assertEquals("Wrong author", "Eisbach", tf.getAuthor());
		assertEquals("Wrong title", "Rock 812", tf.getTitle());
		assertEquals("Wrong album", "The Sea, the Sky", tf.getAlbum());
		assertEquals("Wrong time format", "05:31", tf.getFormattedDuration());
	}
	
	@Test @Ignore
	public void test_computeDuration_01() throws Exception {
		assertEquals("Wrong duration", 2000000L,
				WavFile.computeDuration(88200L, 44100.0f));
	}
	
	@Test @Ignore
	public void test_readSetDurWav_01() throws Exception {
		WavFile wf = new WavFile("audiofiles/wellenmeister - tranquility.wav");
		assertEquals("Wrong time format", "02:21", wf.getFormattedDuration());
		System.out.println(wf.toString());
	}
	
	@Test
	public void testNullTags() {
		AudioFile f = null;
		// The file "audiofiles/kein.wav.sondern.ogg" does not contain tags for author
		// and title
		// We expect that title is derived from filename!
		try {
			f = new TaggedFile("audiofiles/kein.wav.sondern.ogg");
		} catch (NullPointerException e) {
			fail("NullPointerException for TaggedFile with null tags");
		} catch (RuntimeException e) {
			fail("File does not exist " + e);
		}
		assertEquals("Wrong author", "", f.getAuthor());
		assertEquals("Wrong title", "kein.wav.sondern", f.getTitle());
	}
	
}
