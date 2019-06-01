package dmk.sqs.client;

import com.fasterxml.jackson.databind.ObjectMapper;
import dmk.aws.model.S3KeyMessage;
import dmk.s3.S3BucketReader;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.Options;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.ArrayList;
import java.util.stream.Collectors;

public class SQSClientDriver {
    private final Logger logger = LoggerFactory.getLogger(SQSClientDriver.class);

    private String region;
    private String bucket;
    private String queue;
    private String suffix;
    private String prefix;
    private String profile;

    public static void main(String... args) throws Exception {
        System.out.println("Reading from S3 and writing to SQS");

        var options = new Options();
        options.addRequiredOption("b", "bucket", true, "s3 bucket to list files");
        options.addRequiredOption("r", "region", true, "s3 region");
        options.addRequiredOption("p", "profile", true, "profile");
        options.addOption("s", "suffix", true, "suffix to use on bucket list");
        options.addRequiredOption("q", "queue", true, "sqs queue to write file names");

        var parser = new DefaultParser();
        var cmd = parser.parse(options, args);
        var bucket = cmd.getOptionValue("b");
        var queue = cmd.getOptionValue("q");
        var region = cmd.getOptionValue("r");
        var profile = cmd.getOptionValue("p");

        var suffix = "";
        if (cmd.hasOption("s")) {
            suffix = cmd.getOptionValue("s");
        }
        var logMsg = String.format("region = %s, bucket = %s, queue = %s, suffix = %s", region, bucket, queue, suffix);
        System.out.println(logMsg);
        var driver = new SQSClientDriver(bucket, queue, region, profile, suffix, "");
        driver.listBucketAndWriteToSQS();
    }

    public SQSClientDriver(String bucket, String queue, String region, String profile, String suffix, String prefix) throws IOException {
        super();
        this.bucket = bucket;
        this.region = region;
        this.profile = profile;
        this.queue = queue;
        this.suffix = suffix;
        this.prefix = prefix;
    }

    /**
     * list s3 bucket keys and send the listing to an sqs queue
     */
    public void listBucketAndWriteToSQS() throws IOException {
        var mapper = new ObjectMapper();
        var keys = S3BucketReader.listBucketKeys(this.region, this.profile, this.bucket);
        logger.debug("{} key(s) found", keys.size());
        var filteredKeys = keys.stream().filter(key -> key.endsWith(suffix)).collect(Collectors.toList());
        var msgs = new ArrayList<String>(filteredKeys.size() * 2);
        logger.debug("{} filtered key(s) found", filteredKeys.size());
        for (int i = 0; i < filteredKeys.size(); i++) {
            var key = filteredKeys.get(i);
            var msg = new S3KeyMessage(this.bucket, key);
            var json = mapper.writeValueAsString(msg);
            logger.debug("{}", json);
            msgs.add(json);
        }

        var sqsHandler = new SQSHandler(this.queue, profile);
        sqsHandler.sendMessages(msgs);

        //for demo
//        sqsHandler.receiveMessages();
//        sqsHandler.deleteMessages(sqsHandler.receiveMessages());
//        sqsHandler.purgeMessages();
    }

}
