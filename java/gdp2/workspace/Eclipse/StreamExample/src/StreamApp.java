import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.stream.Stream;

public class StreamApp {

	public static void main(String args[]) {
		
		Stream<String> myStream = Stream.empty();
		
		try {
			myStream = Files.lines(Paths.get("src/Text.txt"));
		}
		catch (Exception e) {
		}
		
		long myZahl = 
		myStream
			.map(s -> s.toLowerCase())
			.map(s -> s.replaceAll("[^a-z | ]", ""))
			.flatMap(line -> Arrays.stream(line.split(" ")))
			.distinct()
			.sorted()
			.count();
			// .forEach(p -> System.out.printf(p + "  "));
		System.out.println(myZahl);
		
		
		myZahl = Stream.of(1, 2, 3, 4, 5).reduce(0, (a,b) -> a+b);
		System.out.println(myZahl);
		
		Stream.of(1, 2, 3, 4, 5).toArray();
	
		Stream.generate(() -> Math.random())
			.forEach(System.out::println);
		
	}
	
}
