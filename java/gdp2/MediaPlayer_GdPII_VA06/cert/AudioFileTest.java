import static org.junit.Assert.assertEquals;
import static org.junit.Assert.fail;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class AudioFileTest {

    private static char sep;

    private static String root = "/";

    private static String pathNames[];

    private static String expectedPathNames[];

    private static String expectedFileNames[];

    private static String authors[];

    private static String titles[];

    private static String toStrings[];

    @Before
    public void setUp() {
        try {
            // Activate exactly one the following lines
            // in order to define the emulation you like
            // Usually, the first line (no emulation) is active
            //
            EmulateOtherOs.reset(); // no emulation
            EmulateOtherOs.emulateWindows();
            // EmulateOtherOs.emulateLinux();
            // EmulateOtherOs.emulateMac();
        } catch (Exception e) {
            e.printStackTrace();
        }
        sep = System.getProperty("file.separator").charAt(0);
        String osname = System.getProperty("os.name");
        if (osname.toLowerCase().indexOf("win") >= 0)
            root = "C:" + sep;

        // This array contains the arguments we feed to method parsePathname()
        pathNames = new String[] {
                "home" + sep + "meier" + sep + "Musik" + sep + "Falco - Rock Me Amadeus.mp3",
                "home" + sep + "db-admin" + sep + "Frankie Goes To Hollywood - The Power Of Love.ogg",
                root + "tmp" + sep + "Deep Purple - Smoke On The Water.wav",
                root + "my-tmp" + sep + "file.mp3",
                "Falco - Rock Me Amadeus.mp3",
                "file.mp3",
                ".." + sep + "music" + sep + "audiofile.au",
                "   A.U.T.O.R   -   T.I.T.E.L   .EXTENSION",
                "Hans-Georg Sonstwas - Blue-eyed boy-friend.mp3",
                // Some more ugly test cases.
                // Note that arbitrary combinations of / and \ are provided.
                // Consecutive occurrences of these are to be squeezed and
                // replaced by a single separator that corresponds to
                // the platform running the application (use System.getProperty("file.separator").charAt(0)).
                // Further note that spaces and tabs (white space) are not
                // altered by this normalization.
                "",
                " ",
                "//your-tmp/part1//file.mp3/",
                "../your-tmp/..//part1//file.mp3/",
                "\\file.mp3",
                "\\part1\\\\file.mp3\\",
                "\\part1///file.mp3",
                "/MP3-Archiv/.nox",
                "/MP3-Archiv/Falco - Rock me Amadeus.",
                "-",
                " -  "
        };

        // Array of the results expected from method getPathname() 
        // We expect normalization with respect to consecutive occurrences of / and \
        // and replacement by a single System.getProperty("file.separator").charAt(0)
        // Spaces and tabs (white space) are not altered.
        expectedPathNames = new String[] {
                "home" + sep + "meier" + sep + "Musik" + sep + "Falco - Rock Me Amadeus.mp3",
                "home" + sep + "db-admin" + sep + "Frankie Goes To Hollywood - The Power Of Love.ogg",
                root + "tmp" + sep + "Deep Purple - Smoke On The Water.wav",
                root + "my-tmp" + sep + "file.mp3",
                "Falco - Rock Me Amadeus.mp3",
                "file.mp3",
                ".." + sep + "music" + sep + "audiofile.au",
                "   A.U.T.O.R   -   T.I.T.E.L   .EXTENSION",
                "Hans-Georg Sonstwas - Blue-eyed boy-friend.mp3",
                // Some more ugly test cases
                "",
                " ",
                sep + "your-tmp" + sep + "part1" + sep + "file.mp3" + sep,
                ".." + sep + "your-tmp" + sep + ".." + sep + "part1" + sep + "file.mp3" + sep,
                sep + "file.mp3",
                sep + "part1" + sep + "file.mp3" + sep,
                sep + "part1" + sep + "file.mp3",
                sep + "MP3-Archiv" + sep + ".nox",
                sep + "MP3-Archiv" + sep + "Falco - Rock me Amadeus.",
                "-",
                " -  "
        };

        // Array of the results expected from method getFilename() 
        // Spaces and tabs (white space) are not altered.
        expectedFileNames = new String[] {
                "Falco - Rock Me Amadeus.mp3",
                "Frankie Goes To Hollywood - The Power Of Love.ogg",
                "Deep Purple - Smoke On The Water.wav",
                "file.mp3",
                "Falco - Rock Me Amadeus.mp3",
                "file.mp3",
                "audiofile.au",
                "   A.U.T.O.R   -   T.I.T.E.L   .EXTENSION",
                "Hans-Georg Sonstwas - Blue-eyed boy-friend.mp3",
                // Some more ugly test cases
                "",
                " ",
                "",
                "",
                "file.mp3",
                "",
                "file.mp3",
                ".nox",
                "Falco - Rock me Amadeus.",
                "-",
                " -  "
        };

        // Array of the results expected from method getAuthor() 
        // Leading and trailing spaces and tabs (white space) are trimmed.
        authors = new String[] {
                "Falco",
                "Frankie Goes To Hollywood",
                "Deep Purple",
                "",
                "Falco",
                "",
                "",
                "A.U.T.O.R",
                "Hans-Georg Sonstwas",
                // Some more ugly test cases
                "", 
                "",
                "",
                "",
                "",
                "",
                "",
                "",
                "Falco",
                "",
                ""
        };

        // Array of the results expected from method getTitle() 
        // Leading and trailing spaces and tabs (white space) are trimmed.
        titles = new String[] {
                "Rock Me Amadeus",
                "The Power Of Love",
                "Smoke On The Water",
                "file",
                "Rock Me Amadeus",
                "file",
                "audiofile",
                "T.I.T.E.L",
                "Blue-eyed boy-friend",
                // Some more ugly test cases
                "",
                "",
                "",
                "",
                "file",
                "",
                "file",
                "",
                "Rock me Amadeus",
                "-",
                ""
        };

        // Array of the results expected from method toString() 
        toStrings = new String[] {
                "Falco - Rock Me Amadeus",
                "Frankie Goes To Hollywood - The Power Of Love",
                "Deep Purple - Smoke On The Water",
                "file",
                "Falco - Rock Me Amadeus",
                "file",
                "audiofile",
                "A.U.T.O.R - T.I.T.E.L",
                "Hans-Georg Sonstwas - Blue-eyed boy-friend",
                // Some more ugly test cases
                "",
                "",
                "",
                "",
                "file",
                "",
                "file",
                "",
                "Falco - Rock me Amadeus",
                "-",
                ""
        };
    }

    @After
    public void tearDown() {
        try {
            EmulateOtherOs.reset();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testSettersAndGetters() {
        // Use the constructor without arguments
        String current = null;
        try {
            for (int i = 0; i < pathNames.length; i++) {
                String p = pathNames[i];
                current = p;

                AudioFile af = new AudioFile();
                af.parsePathname(p);
                af.parseFilename(af.getFilename());

                assertEquals("getPathname() fuer Testfall [" + i + "]: " + p
                        + " nicht korrekt", expectedPathNames[i],
                        af.getPathname());
                assertEquals("getFilename() fuer Testfall [" + i + "]: " + p
                        + " nicht korrekt", expectedFileNames[i],
                        af.getFilename());
                assertEquals("getAuthor() fuer Testfall [" + i + "]: " + p
                        + " nicht korrekt", authors[i], af.getAuthor());
                assertEquals("getTitle() fuer Testfall [" + i + "]: " + p
                        + " nicht korrekt", titles[i], af.getTitle());
                assertEquals("toString() fuer Testfall [" + i + "]: " + p
                        + " nicht korrekt", toStrings[i], af.toString());
            }
        } catch (Exception e) {
            fail("Fehler fuer pathname:" + current + ":" + e);
        }
    }

    @Test
    public void testCtor() {
        // Perform the same getter and setter tests by using the ctor with one
        // argument for construction
        String current = null;
        try {
            for (int i = 0; i < pathNames.length; i++) {
                String p = pathNames[i];
                current = p;

                AudioFile af = new AudioFile(p);
                assertEquals("getPathname() fuer Testfall [" + i + "]: " + p
                        + " nicht korrekt", expectedPathNames[i],
                        af.getPathname());
                assertEquals("getFilename() fuer Testfall [" + i + "]: " + p
                        + " nicht korrekt", expectedFileNames[i],
                        af.getFilename());
                assertEquals("getAuthor() fuer Testfall [" + i + "]: " + p
                        + " nicht korrekt", authors[i], af.getAuthor());
                assertEquals("getTitle() fuer Testfall [" + i + "]: " + p
                        + " nicht korrekt", titles[i], af.getTitle());
                assertEquals("toString() fuer Testfall [" + i + "]: " + p
                        + " nicht korrekt", toStrings[i], af.toString());
            }
        } catch (Exception e) {
            fail("Fehler fuer pathname:" + current + ":" + e);
        }
    }

    // A test case for the treatment of drive letters.
    // If a drive specifier (a single letter followed by :)
    // is provided it is to be replaced according to the platform.
    // On windows:        d: --> d:  (no transformation of drive specifier)
    // On other platform: d: --> /d/ or more precisely sep + "d" + sep
    @Test
    public void test_TreatmentOfDriveLetters_01() {
        AudioFile af = new AudioFile();
        af.parsePathname("Z:\\part1\\\\file.mp3\\");

        char sep = System.getProperty("file.separator").charAt(0);

        if (isWindows()) {
            // On Windows we expect "Z:\part1\file.mp3\"
            assertEquals("Pathname stored incorrectly",
                    "Z:" + sep + "part1" + sep + "file.mp3" + sep,
                    af.getPathname());
        } else {
            // On other platforms we expect "/Z/part1/file.mp3/" 
            assertEquals("Pathname stored incorrectly",
                    sep + "Z" + sep + "part1" + sep + "file.mp3" + sep,
                    af.getPathname());
        }
        assertEquals("Returned filename is incorrect", "", af.getFilename());
    }

    // A test case for the treatment of drive letters
    @Test
    public void test_TreatmentOfDriveLetters_02() {
        AudioFile af = new AudioFile();
        af.parsePathname("Z:///part1//file.mp3");

        char sep = System.getProperty("file.separator").charAt(0);

        if (isWindows()) {
            // On Windows we expect "Z:\part1\file.mp3"
            assertEquals("Pathname stored incorrectly", 
                    "Z:" + sep + "part1" + sep + "file.mp3",
                    af.getPathname());
        } else {
            // On other platforms we expect "/Z/part1/file.mp3/" 
            assertEquals("Pathname stored incorrectly",
                    sep + "Z" + sep + "part1" + sep + "file.mp3",
                    af.getPathname());
        }
        assertEquals("Returned filename is incorrect", "file.mp3", af.getFilename());
    }

    // A test case for the treatment of drive letters
    @Test
    public void test_TreatmentOfDriveLetters_03() {
        AudioFile af = new AudioFile();
        af.parsePathname("Z:///file.mp3");

        char sep = System.getProperty("file.separator").charAt(0);

        if (isWindows()) {
            // On Windows we expect "Z:\file.mp3"
            assertEquals("Pathname stored incorrectly", 
                    "Z:" + sep + "file.mp3",
                    af.getPathname());
        } else {
            // On other platforms we expect "/Z/file.mp3" 
            assertEquals("Pathname stored incorrectly",
                    sep + "Z" + sep + "file.mp3",
                    af.getPathname());
        }
        assertEquals("Returned filename is incorrect", "file.mp3", af.getFilename());
    }
 
    //----------------------Test 1
    @Test
    public void test_parsePathname_xy1() throws Exception {
        AudioFile af = new AudioFile();
        af.parsePathname("/part1/mymusic/ -");
        char sepchar = System.getProperty("file.separator").charAt(0);
        assertEquals("Pathname stored incorrectly", sepchar + "part1" + sepchar +
                    "mymusic" + sepchar + " -", af.getPathname());
        assertEquals("Returned filename is incorrect", " -", af.getFilename());
    }
    
    //-------------------------------------------------------------------------------------------
    //----------------------Test 2
    @Test
    public void test_parsePathname_xy2() throws Exception {
        AudioFile af = new AudioFile();
        af.parsePathname("\\nocheinsong\\- ");
        char sepchar = System.getProperty("file.separator").charAt(0);
        assertEquals("Pathname stored incorrectly", sepchar  +"nocheinsong" +
                    sepchar + "- ", af.getPathname());
        assertEquals("Returned filename is incorrect", "- ", af.getFilename());
    }
    //---------------------------------------------------------------------------------------------


    /*--------------------------------------------------------------------------
     * Auxiliary methods 
     */

    private boolean isWindows() {
        return System.getProperty("os.name").toLowerCase().indexOf("win") >= 0;
    }
}
