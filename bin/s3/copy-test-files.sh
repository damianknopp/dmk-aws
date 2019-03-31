#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh

cd files
for f in *.csv; do
    aws s3 cp ${f} s3://${src_s3_bucket}/${f}
done
