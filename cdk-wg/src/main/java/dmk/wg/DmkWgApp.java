package dmk.wg;

import software.amazon.awscdk.core.App;
import software.amazon.awscdk.core.Environment;
import software.amazon.awscdk.core.StackProps;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class DmkWgApp {

    // Helper method to build an environment
    static Environment makeEnv(String account, String region) {
        return Environment.builder()
                .account(account)
                .region(region)
                .build();
    }

    public static void main(final String[] args) throws IOException {
        var app = new App();

        var userData = "";
        var baseName = "";
        var account = "";
        var region = "";
        if (args.length > 0) {
            var arguments = args[0].split(" ");
            account = arguments[0];
            region = arguments[1];
            baseName = arguments[2];
            var userDataFileName = arguments[3];
            userData = Files.readString(Path.of(userDataFileName));
        }
        var env = makeEnv(account, region);
        new DmkWgStack(app,baseName + "-stack", StackProps.builder().env(env).build(), baseName, userData);
        app.synth();
    }
}
