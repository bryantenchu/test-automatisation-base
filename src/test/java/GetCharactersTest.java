import com.intuit.karate.junit5.Karate;

public class GetCharactersTest {
    
    static {
        System.setProperty("karate.ssl", "true");
    }
    
    @Karate.Test
    Karate testGetCharacters() {
        return Karate.run("classpath:get-characters.feature");
    }
}