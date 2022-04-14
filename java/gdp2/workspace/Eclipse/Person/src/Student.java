
public class Student extends Person{
	
	private String matnr;
	private String studiengang;

	public Student(String pAnrede, String pVorname, String pName, String pGeb, String pMatnr, String pStudiengang) {
		super(pAnrede, pVorname, pName, pGeb);
		matnr = pMatnr;
		studiengang = pStudiengang;
	}

	public String getMatnr() {
		return matnr;
	}

	public String getStudiengang() {
		return studiengang;
	}
}
