package dmk.s3;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;
import java.util.stream.Collectors;

import com.amazonaws.auth.profile.ProfileCredentialsProvider;
import com.amazonaws.services.sqs.AmazonSQSClientBuilder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.amazonaws.auth.DefaultAWSCredentialsProviderChain;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.S3Object;
import com.amazonaws.services.s3.model.S3ObjectInputStream;
import com.amazonaws.util.IOUtils;

public class S3BucketReader {
    private static final Logger logger = LoggerFactory.getLogger(S3BucketReader.class);

    /**
     * open stream for given s3 bucket and key
     *
     * @param region
     * @param bucketName
     * @param key
     * @return
     */
    public static List<String> listBucketKeys(final String region, final String profile, final String bucketName) {
        var s3 = S3BucketReader.openS3(region, profile);
        return S3BucketReader.listBucketKeys(s3, bucketName);
    }

    /**
     * open stream for given s3 bucket and key
     *
     * @param region
     * @param bucketName
     * @param key
     * @return
     */
    public static List<String> listBucketKeys(final AmazonS3 s3, final String bucketName) {
        var listing = s3.listObjects(bucketName);
        var objectSummaries = listing.getObjectSummaries();
        return objectSummaries.stream().map(summary -> summary.getKey()).collect(Collectors.toList());
    }

    /**
     * open stream for given s3 bucket and key
     *
     * @param region
     * @param bucketName
     * @param key
     * @return
     */
    public static S3ObjectInputStream openBucketStream(final String region,
                                                       final String bucketName,
                                                       final String key) throws IOException {
        var s3 = S3BucketReader.openS3(region);
        try (final S3Object fullObject = s3.getObject(new GetObjectRequest(bucketName, key))) {
            return fullObject.getObjectContent();
        }
    }

    /**
     * @param region
     * @param bucketName
     * @param key
     * @return
     * @throws IOException
     */
    public static byte[] readBucketAsBytes(final String region,
                                           final String bucketName,
                                           final String key) throws IOException {
        var stream = S3BucketReader.openBucketStream(region, bucketName, key);
        try {
            final byte[] content = IOUtils.toByteArray(stream);
            if (logger.isInfoEnabled()) {
                logger.info("read " + content.length + " bytes");
            }
            return content;
        } finally {
            stream.close();
        }
    }

    /**
     * @param inputStream
     * @return
     * @throws IOException
     */
    private static String readBucketAsString(final String region,
                                             final String bucketName,
                                             final String key) throws IOException {
        var stream = S3BucketReader.openBucketStream(region, bucketName, key);
        try {
            return new BufferedReader(new InputStreamReader(stream)).lines().collect(Collectors.joining("\n"));
        } finally {
            stream.close();
        }
    }

    private static AmazonS3 openS3(final String region) {
        return S3BucketReader.openS3(region, "default");
    }

    private static AmazonS3 openS3(final String region, final String profileName) {
//        return AmazonS3ClientBuilder.standard().withRegion(region)
//                .withCredentials(DefaultAWSCredentialsProviderChain.getInstance()).build();
        AmazonS3ClientBuilder clientBuilder = AmazonS3ClientBuilder.standard();
        clientBuilder.setRegion(region);
        ProfileCredentialsProvider credentialsProvider = new ProfileCredentialsProvider();
        if (profileName != null) {
            credentialsProvider = new ProfileCredentialsProvider(profileName);
        }
        clientBuilder.setCredentials(credentialsProvider);
        return clientBuilder.build();
    }
}