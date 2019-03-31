package dmk.aws.model;

public class S3KeyMessage {

    private String key;
    private String bucket;

    // noop constructor for JSON serializer
    public S3KeyMessage() {
        super();
    }

    public S3KeyMessage(String bucket, String key) {
        super();
        this.bucket = bucket;
        this.key = key;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getBucket() {
        return bucket;
    }

    public void setBucket(String bucket) {
        this.bucket = bucket;
    }
}
