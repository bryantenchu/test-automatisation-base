import com.intuit.karate.junit5.Karate;

public class UpdateCharacterTest {
    
    static {
        System.setProperty("karate.ssl", "true");
    }
    
    @Karate.Test
    Karate testUpdateCharacter() {
        return Karate.run("classpath:update-character.feature");
    }

}
