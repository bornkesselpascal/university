import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNull;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;

import org.junit.Ignore;
import org.junit.Test;

public class PlayListTest {
    private Class<PlayList> clazz = PlayList.class;

    // Check class hierarchy
    @Test
    public void testSuperClass() {
        assertEquals("Wrong base class for PlayList",
                "java.util.LinkedList<AudioFile>",
                clazz.getGenericSuperclass().toString());
    }

    // Note: we do not check the behavior of setCurrent()/getCurrent() with respect
    // to underflow/overflow of the PlayList. Also maintenance of the index
    // as a result of deletions of files from the PlayList is not specified.
    // You may or may not invalidate the current index.
    // Whether arguments of setCurrent() are to be checked for validity is not specified. 
    // The specific behavior for these cases is designed by the implementor.
    //
    // However, for a PlayList pl just created and filled with some files
    //  - getCurrent() should yield 0
    //  - advancing in sequential mode with changeCurrent() should yield an
    //    incremented value by getCurrent() and
    //  - after advancing up to and beyond the end of the list
    //    getCurrent() should yield 0 again (wrap around)   
    //
    @Test
    public void testGetCurrent() {
        PlayList pl = new PlayList();
        try {
            pl.add(new TaggedFile("audiofiles/Rock 812.mp3"));
            pl.add(new WavFile("audiofiles/wellenmeister - tranquility.wav"));
            pl.add(new TaggedFile("audiofiles/wellenmeister_awakening.ogg"));
            pl.add(new TaggedFile("audiofiles/Haydn - Symphonie # 96 Motiv.ogg"));
        } catch (Exception e) {
            fail("Unable to create AudioFile:" + e.getMessage());
        }
        
        assertEquals("Wrong initialization of current index", 0, pl.getCurrent());
        pl.setRandomOrder(false);
        for (int i=0; i < pl.size(); i++) {
            assertEquals("Wrong current index", i, pl.getCurrent());
            pl.changeCurrent();
        }
        assertEquals("Wrong current index; expected wrap around", 0 , pl.getCurrent());
    }
    
    // - getCurrentAudioFile() on empty list should return null
    // -                       non null otherwise
    // - Create a play list with n files
    // - Do a sequential test
    // - Do a random order test
    // - Check that random mode is really random
    
    @Test
    public void testGetSetChangeCurrent() {
        PlayList pl = new PlayList();
        try {
            assertNull(pl.getCurrentAudioFile());
        } catch (IllegalArgumentException e) {
            fail("getCurrentAudioFile() yields exception for empty PlayList");
        }
        try {
            pl.add(new TaggedFile("audiofiles/Rock 812.mp3"));
            pl.add(new WavFile("audiofiles/wellenmeister - tranquility.wav"));
            pl.add(new TaggedFile("audiofiles/wellenmeister_awakening.ogg"));
            pl.add(new TaggedFile("audiofiles/Haydn - Symphonie # 96 Motiv.ogg"));
        } catch (Exception e) {
            fail("Unable to create AudioFile:" + e.getMessage());
        }

        // The next test depends on the fact that we added 3 files to the PlayList
        // Since we added 3 AudioFiles we expect a length of 3
        assertEquals("Wrong size of PlayList", 4, pl.size());
        
        // From here on we do no longer depend on the exact number of files
        // we add to the PlayList in this test
        
        // Test changeCurrent in sequential mode (no random order)
        pl.setCurrent(0);
        pl.setRandomOrder(false);
        for (int i = 0; i < 5 * pl.size(); i++) {
            assertEquals(
                    "Wrong value for getCurrent() in sequential mode",
                    i % pl.size(), pl.getCurrent());
            pl.changeCurrent();
        }
        // Test changeCurrent in random mode
        pl.setCurrent(0);
        pl.setRandomOrder(true);
        // In random mode a call to changeCurrent() should only shuffle
        // if the current index points already to the end of the list.
        // However, after shuffling the current index should be set to 0 again.
        // 
        // If not yet at the end of the list changeCurrent() should simply increment
        for (int i = 0; i < 5 * pl.size(); i++) {
            assertEquals(
                    "Wrong value for getCurrent() in random mode",
                    i % pl.size(), pl.getCurrent());
            pl.changeCurrent();
        }
        
        // Shuffle N >> n! times where n = pl.size()  (we test with 50 * n!)
        // Expecting n! different shuffles
        HashMap<String, Integer> configurations = new HashMap<String, Integer>();
        for (int i = 0; i < 50 * fact(pl.size()); i++) {
            if (i % pl.size() == 0) {
                // Rational: list should be shuffled every n-th time if n is size of PlayList
                // Store the configuration of the list(we just store the concatenated strings of)
                // We just store the concatenated strings of pl.toString()
                String conf = pl.toString();
                Integer val = configurations.get(conf);
                if (val == null) {
                    // Store new configuration
                    configurations.put(conf, 1);
                } else {
                    configurations.put(conf, val + 1);
                }
            }
            pl.changeCurrent();
        }
        assertEquals("Random order mode does not yield all possible shuffles", fact(pl.size()),
                configurations.size());
    }

    
    @Test
    /**
     * Checks if no shuffling is being done in normal, i.e. sequential 
     * mode (randomOrder == false).
     * 
     * - create two playlists with identical Audiofiles
     * - run over first list multiple times using changeCurrent() 
     *   and compare with second list, entries should be identical
     * 
     */
    public void testSequentialMode() {
        PlayList pl = new PlayList();
        try {
            assertNull(pl.getCurrentAudioFile());
        } catch (IllegalArgumentException e) {
            fail("getCurrentAudioFile() yields exception for empty PlayList");
        }
        try {
            pl.add(new TaggedFile("audiofiles/Rock 812.mp3"));
            pl.add(new WavFile("audiofiles/wellenmeister - tranquility.wav"));
            pl.add(new TaggedFile("audiofiles/wellenmeister_awakening.ogg"));
            pl.add(new TaggedFile("audiofiles/Haydn - Symphonie # 96 Motiv.ogg"));
        } catch (Exception e) {
            fail("Unable to create AudioFile:" + e.getMessage());
        }

        // create second list with identical entries 
    	PlayList plCompare = new PlayList();
    	for (int i = 0; i < pl.size(); i++) {
    		plCompare.add(pl.get(i));
    	}

        // Test changeCurrent in sequential mode (no random order)
    	pl.setRandomOrder(false);
    	pl.setCurrent(0);    	
    	for (int i = 0; i < 5 * pl.size(); i++) {
    	    assertEquals(
    	        "Wrong value for getCurrentAudioFile() in sequential mode",
    	         pl.getCurrentAudioFile(), plCompare.getCurrentAudioFile());
    	     pl.changeCurrent();
    	     plCompare.changeCurrent();
    	}
    }
    
    // A helper for calculating the number of possible shuffles
    private int fact(int n) {
        int fact=1;
        for (int i=1; i<=n; i++) {
            fact *= i;
        }
        return fact;
    }

    // Here we implicitly check that the elements in the PlayList pl
    // are addressed via index values 0 <= n < pl.size()
    // 
    @Test
    public void testGetCurrentAudioFile() {
        PlayList pl = new PlayList();
        // A newly created PlayList is empty
        // Thus, getCurrentAudioFile() should yield null
        assertNull(pl.getCurrentAudioFile());
        try {
            pl.add(new TaggedFile("audiofiles/Rock 812.mp3"));
            pl.add(new WavFile("audiofiles/wellenmeister - tranquility.wav"));
            pl.add(new TaggedFile("audiofiles/wellenmeister_awakening.ogg"));
            pl.add(new TaggedFile("audiofiles/Haydn - Symphonie # 96 Motiv.ogg"));
        } catch (Exception e) {
            fail("Unable to create AudioFile:" + e.getMessage());
        }
        
        pl.setCurrent(1);
        AudioFile f1 = pl.getCurrentAudioFile();
        assertEquals("getCurrentAudioFile() yields wrong AudioFile",
                "wellenmeister - tranquility - 02:21", f1.toString());
        pl.setCurrent(0);
        AudioFile f0 = pl.getCurrentAudioFile();
        assertEquals("getCurrentAudioFile() yields wrong AudioFile",
                "Eisbach - Rock 812 - The Sea, the Sky - 05:31", f0.toString());
    }

    @Test
    public void testSaveAndLoadM3U() {
        // Create a play list
        PlayList pl1 = new PlayList();
        try {
            pl1.add(new TaggedFile("audiofiles/Rock 812.mp3"));
            pl1.add(new WavFile("audiofiles/wellenmeister - tranquility.wav"));
            pl1.add(new TaggedFile("audiofiles/wellenmeister_awakening.ogg"));
            pl1.add(new TaggedFile("audiofiles/Haydn - Symphonie # 96 Motiv.ogg"));
        } catch (Exception e) {
            fail("Unable to create AudioFile:" + e.getMessage());
        }
        
        // Save PlayList to M3U file
        final String m3uName = "pl.m3u";   
        pl1.saveAsM3U(m3uName);
        
        // Check whether we managed to write the file
        File m3u = new File(m3uName);
        assertTrue("Unable to create M3U file", m3u.exists());

        // Append some comments to the M3U file
        try {
            FileWriter fw = new FileWriter(m3u, true);
            String sep = System.getProperty("line.separator");
            fw.write("# comment" + sep);
            fw.write("     " + sep);
            fw.write("# fake.ogg" + sep);
            fw.close();
        } catch (IOException e) {
            fail("Unable to append to M3U file:" + e.toString());
        }
        pl1 = null;
        
        // Try to load the PlayList again
        PlayList pl2 = null;

        pl2 = new PlayList(m3uName);
        assertEquals(
                "Load PlayList from M3U file yields wrong result",
                "[Eisbach - Rock 812 - The Sea, the Sky - 05:31, "
                        + "wellenmeister - tranquility - 02:21, "
                        + "Wellenmeister - TANOM Part I: Awakening - TheAbsoluteNecessityOfMeaning - 05:55, "
                        + "Haydn - Symphonie # 96 Motiv - Musikschnipsel - 00:03]",
                pl2.toString());
        // Cleanup
        m3u.delete();
    }

    @Test
    public void testExceptionDueToNonExistentM3UFile() {
        try {
            new PlayList("does not exist.m3u");
            fail("Expected exception not thrown for non-existing PlayList file!");
        } catch (Exception e) {
            // Expected
        }
    }

    @Test
    public void testMultipleShuffle() {
        PlayList pl = new PlayList();
        pl.setRandomOrder(true);
        try {
            pl.add(new TaggedFile("audiofiles/Rock 812.mp3"));
            pl.add(new WavFile("audiofiles/wellenmeister - tranquility.wav"));
            pl.add(new TaggedFile("audiofiles/wellenmeister_awakening.ogg"));
            pl.add(new TaggedFile("audiofiles/Rock 812.mp3"));
            pl.add(new WavFile("audiofiles/wellenmeister - tranquility.wav"));
            pl.add(new TaggedFile("audiofiles/wellenmeister_awakening.ogg"));
        } catch (Exception e) {
            fail("Unable to create AudioFile:" + e.getMessage());
        }
        String s1 = pl.toString();
        pl.changeCurrent();
        String s2 = pl.toString();
        pl.changeCurrent();
        String s3 = pl.toString();
        // Rational: the following test fails if the list is shuffled each
        // time we call changeCurrent().
        // Our test list has more than 2 elements. Therefore, the
        // requested shuffle at the end of the list should only occur once
        // during two consecutive calls to changeCurrent(). The other
        // call to changeCurrent() should not shuffle again. 
        assertTrue("Do not shuffle during each call to PlayList.changeCurrent()",
                s1.equals(s2) || s2.equals(s3));
    }
}
