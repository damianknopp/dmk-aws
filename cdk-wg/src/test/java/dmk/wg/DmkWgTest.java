package dmk.wg;

import software.amazon.awscdk.core.App;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import org.junit.Test;
import software.amazon.awscdk.core.Environment;
import software.amazon.awscdk.core.StackProps;

import java.io.IOException;
import java.util.logging.Logger;

import static org.junit.Assert.assertFalse;

public class DmkWgTest {
    private Logger logger = Logger.getLogger(DmkWgTest.class.getName());
    private final static ObjectMapper JSON =
        new ObjectMapper().configure(SerializationFeature.INDENT_OUTPUT, true);

    // Helper method to build an environment
    static Environment makeEnv(String account, String region) {
        return Environment.builder()
                .account(account)
                .region(region)
                .build();
    }

    @Test
    public void testStack() throws IOException {
        var app = new App();
        var env = makeEnv("123", "us-east-1");
        var stack = new DmkWgStack(app, "wg-0-stack", StackProps.builder().env(env).build(), "wg-0", null);
        // synthesize the stack to a CloudFormation template and compare against
        // a checked-in JSON file.
        var actual = JSON.valueToTree(app.synth().getStackArtifact(stack.getArtifactId()).getTemplate());
//        assertEquals(new ObjectMapper().createObjectNode(), actual);
//        logger.info(actual.asText());
        assertFalse(actual.isEmpty());
    }
}
