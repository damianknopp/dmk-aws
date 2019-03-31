package dmk.aws.model;

public class S3KeyMessage {

    private String key;
    private String bucket;

    public S3KeyMessage(String bucket, String key) {
        super();
        this.key = key;
        this.bucket = bucket;
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
