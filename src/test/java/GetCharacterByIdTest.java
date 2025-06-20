import com.intuit.karate.junit5.Karate;

public class GetCharacterByIdTest {
    
    static {
        System.setProperty("karate.ssl", "true");
    }
    
    @Karate.Test
    Karate testGetCharacterById() {
        return Karate.run("classpath:get-character-by-id.feature");
    }
}
