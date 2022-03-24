package studiplayer.cert;

import java.lang.reflect.Field;

import org.junit.Test;

import static java.lang.reflect.Modifier.*;
import static org.junit.Assert.assertTrue;
import static org.junit.Assert.fail;

import studiplayer.audio.*;
import studiplayer.ui.*;

@SuppressWarnings("rawtypes")
public class AttributesTest {
    // Liste aller Klassen
    private Class[] clazzA = {
            AlbumComparator.class,
            AudioFile.class,
            AudioFileFactory.class,
            AuthorComparator.class,
            DurationComparator.class,
            NotPlayableException.class,
            PlayList.class,
            SampledFile.class,
            SortCriterion.class,
            TaggedFile.class,
            TitleComparator.class,
            WavFile.class,
            Player.class,
            PlayListEditor.class,
            };

    @Test
    public void testAttributes() {
        // Teste alle Klassen im Array clazzA
        for (Class theClass : clazzA) {
            try {
                // Teste alle Attribute
                for (Field field : theClass.getDeclaredFields()) {
                    field.setAccessible(true);
                    String attShort = field.getName();

                    // Attributnamen beginnen mit kleinen Buchstaben
                    //
                    // Ausnahmen:
                    // - synthetische Attribute (etwa Expansionen von ENUMS)
                    // - Konstanten: also Modifier final
                    assertTrue(
                            "Attribut "
                                    + attShort
                                    + "; Name des Attributs soll mit Kleinbuchstaben anfangen",
                            Character.isLowerCase(attShort.charAt(0))
                                    || field.isSynthetic()
                                    || isFinal(field.getModifiers()) );

                    // Attribute sind nicht public
                    //
                    // Ausnahmen:
                    // - statische Attribute: also Modifier static
                    // - synthetische Attribute (diese werden aber auch immer static generiert)
                    int mod = field.getModifiers();
                    // Kodierung der Implikation: a -> b == ~a || b        
                    assertTrue("Zugriff auf Attribut'" + attShort
                            + "' darf nicht public sein!", 
                            !isPublic(mod) || isStatic(field.getModifiers())                            
                    );
                }
            } catch (SecurityException e) {
                fail(e.toString());
            }
        }
    }
}
