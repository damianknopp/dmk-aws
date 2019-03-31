#!/usr/bin/env bash


cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh

cat << EOF > ./create-s3-lambda-trigger.json
"LambdaFunctionConfigurations": [
{
  "Id": "${lambda_id}",
  "LambdaFunctionArn": "${lambda_arn}",
  "Events": [
    "s3:ObjectCreated:*"
  ],
  "Filter": {
    "Key": {
      "FilterRules": [
        {
          "Name": "suffix",
          "Value": "${src_s3_suffix}"
        },
        {
          "Name": "prefix",
          "Value": "{src_s3_prefix}"
        }
      ]
    }
  }
}
]
EOF
# todo assign s3_src_arn for our demo
aws lambda add-permission --function-name ${demo_function} \
 --action lambda:InvokeFunction \
 --principal s3.amazonaws.com \
 --source-arn ${s3_src_arn} \
 --statement-id 1

aws s3api put-bucket-notification-configuration \
--bucket ${src_s3_bucket} \
--notification-configuration file://create-s3-lambda-trigger.json