
public class FigurenThreads {

	public static void main(String[] args) {
		EineFigur myFigur = new EineFigur();
		
		Thread writer = new Thread(new Schreiber(myFigur));
		writer.setDaemon(true);
		Thread reader = new Thread(new Leser(myFigur));
		
		writer.start();
		reader.start();
	}

}
