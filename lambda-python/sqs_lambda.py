import boto3
import os
import json
import base64

# Lambda's environment variables
mapped_data_bucket_prefix = os.environ["S3_BUCKET"]

session = boto3.session.Session()
region_name = session.region_name
s3 = session.resource('s3', region_name)

def stream_s3_file(key):
    print("Streaming file {0} from bucket {1}".format(key, bucket))
    obj = s3.Object(bucket, key)
    str = obj.get()['Body'].read().decode('utf-8')
    return str

def lambda_handler(event, context):
    try:
        for record in event['Records']:
            json_object = json.loads(record['body'])
            bucket = json_object.get("bucket")
            key = json_object.get("key")
            print("bucket: {0}, key: {1}".format(bucket, key))
            contents = stream_s3_file(bucket, key)
            first_line = contents.split('\n')
            print(first_line)

    except Exception as e:
        print(e)
        raise e