package dmk.kinesis.client;

import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.services.kinesis.AmazonKinesis;
import com.amazonaws.services.kinesis.AmazonKinesisClientBuilder;
import com.amazonaws.services.kinesis.model.PutRecordsRequest;
import com.amazonaws.services.kinesis.model.PutRecordsRequestEntry;
import com.amazonaws.services.kinesis.model.PutRecordsResult;
import dmk.aws.client.config.AwsClientConfig;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.nio.ByteBuffer;
import java.util.ArrayList;

public class KinesisClientDriver {
    private final Logger logger = LoggerFactory.getLogger(KinesisClientDriver.class);

    private String region;
    private String defaultStreamName;

    public static void main(String ...args) throws Exception {
        System.out.println("Writing sample records to Kinesis");
        String streamName = null;
        String profileName = null;
        if (args.length > 0) {
            streamName = args[0];
            if (args.length > 1) {
              profileName = args[1];
            }
        }
        var numRecords = 10;
        var driver = new KinesisClientDriver();
        driver.writeSampleRecords(numRecords, streamName, profileName);
    }

    public KinesisClientDriver() throws Exception {
        super();
        init();
    }

    private void init() throws Exception {
        var config = new AwsClientConfig();
        this.region = config.getPropValue("region");
        this.defaultStreamName = config.getPropValue("default.stream.name");
    }

    /**
     * https://docs.aws.amazon.com/streams/latest/dev/developing-producers-with-sdk.html
     * @param numRecords
     */
    public void writeSampleRecords(int numRecords, String streamName, String profileName) throws Exception {
        if (streamName == null) {
            streamName = this.defaultStreamName;
        }
        numRecords = numRecords > 4 ? numRecords : 10;
        var kinesisClient = this.genKinesisClientConnection(this.region, profileName);
        var putRecordsRequest  = new PutRecordsRequest();
        putRecordsRequest.setStreamName(streamName);
        var putRecordsRequestEntryList  = new ArrayList<PutRecordsRequestEntry>();
        for (int i = 0; i < numRecords; i++) {
            var putRecordsRequestEntry  = new PutRecordsRequestEntry();
            putRecordsRequestEntry.setData(ByteBuffer.wrap(String.valueOf(i).getBytes()));
            putRecordsRequestEntry.setPartitionKey(String.format("partitionKey-%d", i));
            putRecordsRequestEntryList.add(putRecordsRequestEntry);
        }

        putRecordsRequest.setRecords(putRecordsRequestEntryList);
        PutRecordsResult putRecordsResult  = kinesisClient.putRecords(putRecordsRequest);
        logger.debug("Put Result" + putRecordsResult);
    }

    /**
     * create kinesis client with local aws profile credentials and configured region
     * @return
     * @throws Exception
     */
    private AmazonKinesis genKinesisClientConnection(String region, String profileName) throws Exception {
        AmazonKinesisClientBuilder clientBuilder = AmazonKinesisClientBuilder.standard();
        clientBuilder.setRegion(region);
        ProfileCredentialsProvider credentialsProvider = new ProfileCredentialsProvider();
        if (profileName != null) {
          credentialsProvider = new ProfileCredentialsProvider(profileName);
        }
        clientBuilder.setCredentials(credentialsProvider);
//        clientBuilder.setClientConfiguration(config);
        var kinesisClient = clientBuilder.build();
        logger.debug("created kinesis client in region " + region + " client " + kinesisClient.toString());
        return kinesisClient;
    }


}
