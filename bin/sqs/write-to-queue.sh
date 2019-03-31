#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh
source ../acct.sh
queue_url="https://sqs.${region}.amazonaws.com/${acct}/${queue_name}"
java -cp ../../sqs-client/target/sqs-client-${version}-jar-with-dependencies.jar dmk.sqs.client.SQSClientDriver --region ${region} --bucket ${src_s3_bucket} --queue ${queue_url} $*