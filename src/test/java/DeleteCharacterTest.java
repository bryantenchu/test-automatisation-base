import com.intuit.karate.junit5.Karate;

public class DeleteCharacterTest {
    
    static {
        System.setProperty("karate.ssl", "true");
    }
    
    @Karate.Test
    Karate testDeleteCharacter() {
        return Karate.run("classpath:delete-character.feature");
    }

}
