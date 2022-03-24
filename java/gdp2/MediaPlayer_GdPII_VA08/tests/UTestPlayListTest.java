import static org.junit.Assert.*;

import org.junit.Test;

public class UTestPlayListTest {

	@Test
	public void test_getCurrentAudioFile_01() throws Exception {
		PlayList pl = new PlayList();
		assertEquals("Wrong current AudioFile", null, pl.getCurrentAudioFile());
	}
	
	@Test
	public void test_getCurrentAudioFile_02() throws Exception {
		PlayList pl = new PlayList();
		TaggedFile tf0 = new TaggedFile("audiofiles/Eisbach Deep Snow.ogg");
		pl.add(tf0);
		pl.setCurrent(10);
		assertEquals("Wrong current AudioFile", null, pl.getCurrentAudioFile());
	}
	
	@Test
	public void test_getCurrentAudioFile_03() throws Exception {
		PlayList pl = new PlayList();
		TaggedFile tf0 = new TaggedFile("audiofiles/Eisbach Deep Snow.ogg");
		pl.add(tf0);
		assertEquals("Wrong current AudioFile", tf0, pl.getCurrentAudioFile());
	}
	
	@Test
	public void test_getCurrentAudioFile_04() throws Exception {
		PlayList pl = new PlayList();
		TaggedFile tf0 = new TaggedFile("audiofiles/Eisbach Deep Snow.ogg");
		TaggedFile tf1 = new TaggedFile("audiofiles/Rock 812.mp3");
		pl.add(tf0);
		pl.add(tf1);
		pl.setCurrent(1);
		assertEquals("Wrong current AudioFile", tf1, pl.getCurrentAudioFile());
		
		pl.remove(0);
		assertEquals("Wrong current AudioFile", null, pl.getCurrentAudioFile());
	}
	
	@Test
	public void test_changeCurrent_01() throws Exception {
		PlayList pl = new PlayList();
		TaggedFile tf0 = new TaggedFile("audiofiles/Eisbach Deep Snow.ogg");
		TaggedFile tf1 = new TaggedFile("audiofiles/tanom p2 journey.mp3");
		TaggedFile tf2 = new TaggedFile("audiofiles/Rock 812.mp3");
		pl.add(tf0);
		pl.add(tf1);
		pl.add(tf2);
		pl.setCurrent(0);
		assertEquals("Wrong current index", 0, pl.getCurrent());
		pl.changeCurrent();
		assertEquals("Wrong current index", 1, pl.getCurrent());
		pl.changeCurrent();
		assertEquals("Wrong current index", 2, pl.getCurrent());
		pl.changeCurrent();
		assertEquals("Wrong current index", 0, pl.getCurrent());
		pl.changeCurrent();
		assertEquals("Wrong current index", 1, pl.getCurrent());
		assertEquals("Wrong current AudioFile", tf1, pl.getCurrentAudioFile());
	}
	
	@Test
	public void test_changeCurrent_02() throws Exception {
		PlayList pl = new PlayList();
		TaggedFile tf0 = new TaggedFile("audiofiles/Eisbach Deep Snow.ogg");
		TaggedFile tf1 = new TaggedFile("audiofiles/tanom p2 journey.mp3");
		TaggedFile tf2 = new TaggedFile("audiofiles/Rock 812.mp3");
		pl.add(tf0);
		pl.add(tf1);
		pl.add(tf2);
		pl.setCurrent(0);
		assertEquals("Wrong current index", 0, pl.getCurrent());
		pl.changeCurrent();
		assertEquals("Wrong current index", 1, pl.getCurrent());
		pl.changeCurrent();
		pl.setCurrent(10);
		assertEquals("Wrong current index", 10, pl.getCurrent());
		pl.changeCurrent();
		assertEquals("Wrong current index", 0, pl.getCurrent());
	}
	
	@Test
	public void test_changeCurrent_03() throws Exception {
		PlayList pl = new PlayList();
		TaggedFile f0 = new TaggedFile("audiofiles/Eisbach Deep Snow.ogg");
		TaggedFile f1 = new TaggedFile("audiofiles/tanom p2 journey.mp3");
		TaggedFile f2 = new TaggedFile("audiofiles/Rock 812.mp3");
		WavFile    f4 = new WavFile("audiofiles/wellenmeister - tranquility.wav");
 		pl.add(f0);
		pl.add(f1);
		pl.add(f2);
		pl.add(f4);
		pl.setRandomOrder(true);
		
		for (int i = 0; i < 5 * pl.size(); i++) {
			System.out.printf("Pos=%d Filename=%s\n", pl.getCurrent(), pl.getCurrentAudioFile().getFilename());
			assertEquals("Wrong current index", i % pl.size(), pl.getCurrent());
			pl.changeCurrent();
			
			if(pl.getCurrent() == 0) {
				System.out.println("");
			}
		}
	}
	
}
