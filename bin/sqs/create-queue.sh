#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh
source ../acct.sh

# writes fail with out the policy kms:GenerateDataKey
#key_id=$(aws kms list-keys | jq .Keys[].KeyId | tr -d '"')

# pip install awscli
dead_letter_name="${queue_name}-dead"
# create deadletter queue
cat << EOF > ./create-deadletter-queue.json
{
  "VisibilityTimeout": "3600",
  "MessageRetentionPeriod": "86400"
}
EOF
aws sqs create-queue --queue-name ${dead_letter_name} --region ${region} --attributes file://create-deadletter-queue.json
sqs_dead_arn="arn:aws:sqs:${region}:${acct}:${dead_letter_name}"



# create msg queue
cat << EOF > ./create-sqs-queue.json
{
    "DelaySeconds": "10",
    "MaximumMessageSize": "262144",
    "MessageRetentionPeriod": "1209600",
    "ReceiveMessageWaitTimeSeconds": "0",
    "RedrivePolicy": "{\"deadLetterTargetArn\": \"${sqs_dead_arn}\",\"maxReceiveCount\": \"5\"}",
    "VisibilityTimeout": "960"
}
EOF
#     "KmsMasterKeyId": "${key_id}"
aws sqs create-queue --queue-name ${queue_name} --region ${region} --attributes file://create-sqs-queue.json

echo "visit https://console.aws.amazon.com/sqs/home"

