#!/usr/bin/env bash

# print commands before running
set -x

cd $( dirname "${BASH_SOURCE[0]}" )
source ./acct.sh

export profile=${profile:-default}
export version=1.0-SNAPSHOT
export region=us-east-1
export prefix="dknopp"
export stream_name="${prefix}-test-stream"
export queue_name="${prefix}-test-queue"
export queue_arn="arn:aws:sqs:${region}:${acct}:${queue_name}"
export tags="environment=demo"
export src_s3_bucket="${prefix}-test-bucket"
export demo_function="${prefix}-demo-function"
export lambda_role="arn:aws:iam::${acct}:role/demo-lambda-role"

OS=$(uname)
# if MacOS, use gdate
#   brew install coreutils
#   brew list coreutils
# also install jq
#   brew install jq
if [[ "${OS}" == "Darwin" ]]; then
    date_cmd=gdate
    readlink_cmd=greadlink
fi

