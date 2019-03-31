package dmk.s3;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.List;
import java.util.stream.Collectors;

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
    public static List<String> listBucketKeys(final String region,
                                              final String bucketName) {
        var s3 = S3BucketReader.openS3(region);
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
        return AmazonS3ClientBuilder.standard().withRegion(region)
                .withCredentials(DefaultAWSCredentialsProviderChain.getInstance()).build();
    }
}