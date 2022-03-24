import static org.junit.Assert.*;

import org.junit.Test;

import studiplayer.audio.AudioFile;
import studiplayer.audio.PlayList;
import studiplayer.audio.SortCriterion;
import studiplayer.audio.TaggedFile;
import studiplayer.audio.WavFile;

public class UTestSort {

	@Test
	public void test_sort_01() throws Exception {
		PlayList pl1 = new PlayList();
		// Populate the playlist
		pl1.add(new TaggedFile("audiofiles/Eisbach Deep Snow.ogg"));
		pl1.add(new WavFile("audiofiles/wellenmeister - tranquility.wav"));
		pl1.add(new TaggedFile("audiofiles/wellenmeister_awakening.ogg"));
		pl1.add(new TaggedFile("audiofiles/tanom p2 journey.mp3"));
		pl1.add(new TaggedFile("audiofiles/Rock 812.mp3"));
		
		// Sort the playlist by title
		pl1.sort (SortCriterion.TITLE);
		// Store the toString() strings of the sorted play lists into an array and compare the arrays

		String exp[] = new String[] {
				"Eisbach - Deep Snow - The Sea, the Sky - 03:18",
				 "Eisbach - Rock 812 - The Sea, the Sky - 05:31",
				 "Wellenmeister - TANOM Part I: Awakening - TheAbsoluteNecessityOfMeaning - 05:55",
				 "Wellenmeister - TANOM Part II: Journey - TheAbsoluteNecessityOfMeaning - 02:52",
				 "wellenmeister - tranquility - 02:21" };
				 
		String sorted [] = new String[5];
		int i = 0;
		for (AudioFile af : pl1) {
			sorted[i] = af.toString();
			i++;
		}
		
		assertArrayEquals("Wrong sorting by title", exp, sorted);
	}
	
	@Test
	public void test_sort_02() throws Exception {
		PlayList pl1 = new PlayList();
		// Populate the playlist
		pl1.add(new TaggedFile("audiofiles/Eisbach Deep Snow.ogg"));
		pl1.add(new WavFile("audiofiles/wellenmeister - tranquility.wav"));
		pl1.add(new TaggedFile("audiofiles/wellenmeister_awakening.ogg"));
		pl1.add(new TaggedFile("audiofiles/tanom p2 journey.mp3"));
		pl1.add(new TaggedFile("audiofiles/Rock 812.mp3"));
		
		// Sort the playlist by title
		pl1.sort (SortCriterion.DURATION);
		// Store the toString() strings of the sorted play lists into an array and compare the arrays

		String exp[] = new String[] {
				"wellenmeister - tranquility - 02:21",
				"Wellenmeister - TANOM Part II: Journey - TheAbsoluteNecessityOfMeaning - 02:52",
				"Eisbach - Deep Snow - The Sea, the Sky - 03:18",
				 "Eisbach - Rock 812 - The Sea, the Sky - 05:31",
				 "Wellenmeister - TANOM Part I: Awakening - TheAbsoluteNecessityOfMeaning - 05:55",
				 };
				 
		String sorted [] = new String[5];
		int i = 0;
		for (AudioFile af : pl1) {
			sorted[i] = af.toString();
			i++;
		}
		
		assertArrayEquals("Wrong sorting by duration", exp, sorted);
	}
}
