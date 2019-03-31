#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh

aws s3 rm s3://${src_s3_bucket} --recursive
aws s3api delete-bucket --bucket ${src_s3_bucket} --region ${region}