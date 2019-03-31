#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh

aws s3api create-bucket --bucket ${src_s3_bucket} --region ${region} --acl private


cat << EOF > ./put-bucket-encryption.json
{
    "ServerSideEncryptionConfiguration": {
        "Rules": [
            {
                "ApplyServerSideEncryptionByDefault": {
                    "SSEAlgorithm": "AES256"
                }
            }
        ]
    }
}
EOF

aws s3api put-bucket-tagging --bucket ${src_s3_bucket} --tagging "TagSet=[{Key=environment,Value=demo}]"
aws s3api put-bucket-encryption --bucket ${src_s3_bucket} --cli-input-json file://put-bucket-encryption.json

echo "visit https://s3.console.aws.amazon.com/s3/buckets"

