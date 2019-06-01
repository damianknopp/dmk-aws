#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh

aws --profile ${profile} s3api head-bucket --bucket ${src_s3_bucket}