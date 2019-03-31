#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh

jar_name=sqs-lambda-${version}.jar
aws s3 cp ../../sqs-lambda/target/${jar_name} s3://${src_s3_bucket}/${jar_name}