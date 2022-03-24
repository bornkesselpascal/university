import static org.junit.Assert.*;

import org.junit.Test;

public class UTestAudioFileFactory {

	@Test
	public void test_getInstance_01() throws Exception {
		try {
			AudioFileFactory.getInstance("unknown.xxx");
			fail("Unknown suffix; expecting exception");
		}
		catch (RuntimeException e) {
			// Expected
		}
	}
	
	@Test
	public void test_getInstance_02() throws Exception {
		try {
			AudioFileFactory.getInstance("nonexistend.mp3");
			fail("File is not readable; expecting exception");
		}
		catch (RuntimeException e) {
			// Expected
		}
	}
	
	@Test
	public void test_getInstance_03() throws Exception {
		AudioFile af1 = AudioFileFactory.getInstance("audiofiles/Eisbach Deep Snow.ogg");
		assertTrue("Expecting object of type TaggedFile", (af1 instanceof TaggedFile));
		
		AudioFile af2 = AudioFileFactory.getInstance("audiofiles/wellenmeister - tranquility.wav");
		assertTrue("Expecting object of type TaggedFile", (af2 instanceof WavFile));
		
		AudioFile af3 = AudioFileFactory.getInstance("audiofiles/special.oGg");
		assertTrue("Expecting object of type TaggedFile", (af3 instanceof TaggedFile));
	}

	
}
