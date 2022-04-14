import java.util.ArrayList;
import java.util.List;

public class UseListFunction {

  // print erhält Funktion als Parameter, das die Schnittstelle Implementiert
  static void print(List<Integer> list, ListFunction<Integer> f) {
    while (!list.isEmpty()) {
      System.out.println(f.apply(list));
      list.remove((Object) f.apply(list));
    }
  }

  // Ausführtung des Apply (gibt Integer zurück)
  static Integer max(List<Integer> list) {
    int max = list.get(0);

    for (Integer i: list) {
      if (i > max)
        max = i;
    }

    return max;
  }

  static Integer nega(List<Integer> list) {
    for (Integer i: list) {
      if (i < 0)
        return i;
    }

    return list.get(0);
  }

  public static void main(String[] args) {
    
	// Erstellung einer Liste  
	ArrayList<Integer> a = new ArrayList<Integer>();
    a.add(3);
    a.add(-1);
    a.add(-2);
    a.add(2);
    
    // Aufruf von print, die Funktion als Parameter erhält
    print(a, l -> max(l));
    print(a, new ListFunction<Integer>() {
    	public Integer apply(List<Integer> list) {
    		return max(list);
    	}
    });
    System.out.println();
    
    a.add(3);
    a.add(-1);
    a.add(-2);
    a.add(2);
    print(a, UseListFunction::nega); 
  }

}
