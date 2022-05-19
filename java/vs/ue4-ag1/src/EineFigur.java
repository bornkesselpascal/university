
public class EineFigur extends Figur{

	@Override
	public synchronized void setPosition(char x, int y) {
		this.x = x;
		MachMal.eineZehntelSekundeLangGarNichts();
		this.y = y;
	}

	@Override
	public synchronized String getPosition() {
		for(int i = 0; i < 10; i++) {
			MachMal.eineZehntelSekundeLangGarNichts();
		}
		String r = String.valueOf(x) + " " + Integer.toString(y);
		return r;
	}

}
