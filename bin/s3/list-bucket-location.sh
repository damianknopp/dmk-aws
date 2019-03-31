#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh

aws s3api get-bucket-location --bucket ${src_s3_bucket}