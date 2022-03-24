import static org.junit.Assert.*;

import org.junit.Test;

public class UTestAudioFile {

	// Pfad (normal)
	@Test
	public void test_parsePathname_03() throws Exception {
		AudioFile af = new AudioFile();
		af.parsePathname("/my-tmp/file.mp3");
		
		char sepchar = java.io.File.separatorChar;
		assertEquals("Pathname stored incorrectly", sepchar + "my-tmp" + sepchar + "file.mp3", af.getPathname());
		assertEquals("Returned filename is incorrect", "file.mp3", af.getFilename());
	}
	
	// Pfad mit vielen Trennzeichen
	@Test
	public void test_parsePathname_04() throws Exception {
		AudioFile af = new AudioFile();
		af.parsePathname("//my-tmp/////part1//file.mp3/");
		
		char sepchar = java.io.File.separatorChar;
		assertEquals("Pathname stored incorrectly", sepchar + "my-tmp" + sepchar + "part1" + sepchar + "file.mp3" + sepchar, af.getPathname());
		assertEquals("Returned filename is incorrect", "", af.getFilename());
	}
	
	// Pfad nur mit Datei
	@Test
	public void test_parsePathname_05() throws Exception {
		AudioFile af = new AudioFile();
		af.parsePathname("file.mp3");
		
		char sepchar = java.io.File.separatorChar;
		assertEquals("Pathname stored incorrectly","file.mp3", af.getPathname());
		assertEquals("Returned filename is incorrect", "file.mp3", af.getFilename());
	}
	
	// Leerer Pfad
	@Test
	public void test_parsePathname_06() throws Exception {
		AudioFile af = new AudioFile();
		af.parsePathname("");
		
		char sepchar = java.io.File.separatorChar;
		assertEquals("Pathname stored incorrectly", "", af.getPathname());
		assertEquals("Returned filename is incorrect", "", af.getFilename());
	}
	
	// Viele Leerzeichen und Tabs
	@Test
	public void test_parsePathname_07() throws Exception {
		AudioFile af = new AudioFile();
		af.parsePathname("   	   		");
		
		char sepchar = java.io.File.separatorChar;
		assertEquals("Pathname stored incorrectly", "   	   		", af.getPathname());
		assertEquals("Returned filename is incorrect", "   	   		", af.getFilename());
	}
	
	// Pfad mit Laufwerksbuchstabe
	@Test
	public void test_parsePathname_08() throws Exception {
		AudioFile af = new AudioFile();
		af.parsePathname("d:\\\\part1//////file.mp3");
		
		char sepchar = java.io.File.separatorChar;
		assertEquals("Pathname stored incorrectly", "d:\\part1\\file.mp3", af.getPathname());
		assertEquals("Returned filename is incorrect", "file.mp3", af.getFilename());
	}
	
	
	
	
	
	@Test
	public void test_parseFilename_09() throws Exception {
		AudioFile af = new AudioFile();
		af.parsePathname("/tmp/test/ Falco  -  Rock me    Amadeus .mp3  ");
		af.parseFilename(af.getFilename());
		
		assertEquals("Filename stored incorrecty", " Falco  -  Rock me    Amadeus .mp3  ", af.getFilename());
		assertEquals("Author stored incorrectly", "Falco", af.getAuthor());
		assertEquals("Returned filename is incorrect", "Rock me    Amadeus", af.getTitle());
	}
	
	@Test
	public void test_parseFilename_10() throws Exception {
		AudioFile af = new AudioFile();
		af.parsePathname("/tmp/test/Sia - Titanium.ogg");
		af.parseFilename(af.getFilename());
		
		assertEquals("Filename stored incorrecty", "Sia - Titanium.ogg", af.getFilename());
		assertEquals("Author stored incorrectly", "Sia", af.getAuthor());
		assertEquals("Returned filename is incorrect", "Titanium", af.getTitle());
	}
	
	@Test
	public void test_parseFilename_11() throws Exception {
		AudioFile af = new AudioFile();
		af.parsePathname("/tmp/test/audiofile.aux");
		af.parseFilename(af.getFilename());
		
		assertEquals("Filename stored incorrecty", "audiofile.aux", af.getFilename());
		assertEquals("Author stored incorrectly", "", af.getAuthor());
		assertEquals("Returned filename is incorrect", "audiofile", af.getTitle());
	}
	
	@Test
	public void test_parseFilename_12() throws Exception {
		AudioFile af = new AudioFile();
		af.parsePathname("/tmp/test/    A.U.T.O.R   -  T.I.T.E.L  .EXTENSION");
		af.parseFilename(af.getFilename());
		
		assertEquals("Filename stored incorrecty", "    A.U.T.O.R   -  T.I.T.E.L  .EXTENSION", af.getFilename());
		assertEquals("Author stored incorrectly", "A.U.T.O.R", af.getAuthor());
		assertEquals("Returned filename is incorrect", "T.I.T.E.L", af.getTitle());
	}
	
	@Test
	public void test_parseFilename_13() throws Exception {
		AudioFile af = new AudioFile();
		af.parsePathname("/tmp/test/AC-DC - Hells-Bells.aac");
		af.parseFilename(af.getFilename());
		
		assertEquals("Filename stored incorrecty", "AC-DC - Hells-Bells.aac", af.getFilename());
		assertEquals("Author stored incorrectly", "AC-DC", af.getAuthor());
		assertEquals("Returned filename is incorrect", "Hells-Bells", af.getTitle());
	}
	
	@Test
	public void test_parseFilename_14() throws Exception {
		AudioFile af = new AudioFile();
		af.parsePathname("/tmp/test/.aac");
		af.parseFilename(af.getFilename());
		
		assertEquals("Filename stored incorrecty", ".aac", af.getFilename());
		assertEquals("Author stored incorrectly", "", af.getAuthor());
		assertEquals("Returned filename is incorrect", "", af.getTitle());
	}
	
	@Test
	public void test_parseFilename_15() throws Exception {
		AudioFile af = new AudioFile();
		af.parsePathname("/tmp/test/AC-DC - Hells-Bells.");
		af.parseFilename(af.getFilename());
		
		assertEquals("Filename stored incorrecty", "AC-DC - Hells-Bells.", af.getFilename());
		assertEquals("Author stored incorrectly", "AC-DC", af.getAuthor());
		assertEquals("Returned filename is incorrect", "Hells-Bells", af.getTitle());
	}
	
	@Test
	public void test_parseFilename_16() throws Exception {
		AudioFile af = new AudioFile();
		af.parsePathname("/tmp/test/-");
		af.parseFilename(af.getFilename());
		
		assertEquals("Filename stored incorrecty", "-", af.getFilename());
		assertEquals("Author stored incorrectly", "", af.getAuthor());
		assertEquals("Returned filename is incorrect", "-", af.getTitle());
	}
	
	@Test
	public void test_parseFilename_17() throws Exception {
		AudioFile af = new AudioFile();
		af.parsePathname("/tmp/test/ - ");
		af.parseFilename(af.getFilename());
		
		assertEquals("Filename stored incorrecty", " - ", af.getFilename());
		assertEquals("Author stored incorrectly", "", af.getAuthor());
		assertEquals("Returned filename is incorrect", "", af.getTitle());
	}
	
	
	
	
	@Test
	public void test_toString_18() throws Exception {
		AudioFile af = new AudioFile();
		af.parsePathname("/tmp/test/Falco - Rock-me - Amadeus.mp3");
		af.parseFilename(af.getFilename());
		
		assertEquals("Filename stored incorrecty", "Falco - Rock-me - Amadeus.mp3", af.getFilename());
		assertEquals("Author stored incorrectly", "Falco", af.getAuthor());
		assertEquals("Returned filename is incorrect", "Rock-me - Amadeus", af.getTitle());
		assertEquals("ToString is wrong!", "Falco - Rock-me - Amadeus", af.toString());
	}
	
	@Test
	public void test_toString_19() throws Exception {
		AudioFile af = new AudioFile();
		af.parsePathname("/tmp/test/DasIstEinLied.aac");
		af.parseFilename(af.getFilename());
		
		assertEquals("Filename stored incorrecty", "DasIstEinLied.aac", af.getFilename());
		assertEquals("Author stored incorrectly", "", af.getAuthor());
		assertEquals("Returned filename is incorrect", "DasIstEinLied", af.getTitle());
		assertEquals("ToString is wrong!", "DasIstEinLied", af.toString());
	}
}
