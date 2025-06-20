import com.intuit.karate.junit5.Karate;

public class CreateCharacterTest {
    
    static {
        System.setProperty("karate.ssl", "true");
    }
    
    @Karate.Test
    Karate testCreateCharacter() {
        return Karate.run("classpath:create-character.feature");
    }
}
