package dmk.aws.client.config;

import java.io.FileNotFoundException;
import java.io.InputStream;
import java.util.Properties;

public class AwsClientConfig {

    private static String propFileName = "aws-client.properties";

    /**
     * @return
     * @throws Exception
     */
    public String getPropValue(String name) throws Exception {
        try (InputStream inputStream = this.getClass().getClassLoader().getResourceAsStream(propFileName)) {
            final Properties prop = new Properties();
            if (inputStream != null) {
                prop.load(inputStream);
            } else {
                throw new FileNotFoundException("property file '" + propFileName + "' not found in the classpath");
            }

            final String property = prop.getProperty(name);
            return property;
        }
    }
}
