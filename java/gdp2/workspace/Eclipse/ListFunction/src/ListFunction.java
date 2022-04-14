import java.util.List;

// Mit <T> parametrisiertes Interface, der eine Funktion beschreibt.

public interface ListFunction<T> {

	T apply(List<T> list);
	
}
