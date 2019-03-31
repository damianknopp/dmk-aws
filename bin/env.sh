#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ./acct.sh

version=1.0-SNAPSHOT
region=us-east-1
prefix="dknopp"
stream_name="${prefix}-test-stream"
queue_name="${prefix}-test-queue"
queue_arn="arn:aws:sqs:${region}:${acct}:${queue_name}"
tags="environment=demo"
src_s3_bucket="${prefix}-test-bucket"
demo_function="${prefix}-demo-function"
lambda_role="arn:aws:iam::${acct}:role/demo-lambda-role"

OS=$(uname)
# if MacOS, use gdate
#   brew install coreutils
#   brew list coreutils
# also install jq
#   brew install jq
if [[ "${OS}" == "Darwin" ]]; then
    date_cmd=gdate
fi

