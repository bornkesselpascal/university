public enum Weekday {

	MONTAG,
	DIENSTAG,
	MITTWOCH,
	DONNERSTAG,
	FREITAG,
	SAMSTAG,
	SONNTAG;
	
	// Neben den bestehenden Methoden können auch eigene Methoden, Arribute und Konstruktoren definiert werden.
	public boolean isWeekend() {
		boolean weekend = (this.equals(SAMSTAG) || this.equals(SONNTAG));
		return weekend;
	}
	
}
