#!/usr/bin/env bash

script_dir=$(dirname "${BASH_SOURCE[0]}")
cd "${script_dir}"
source ../env.sh

cd ${script_dir}/files
for f in *.csv; do
    aws --profile ${profile} s3 cp ${f} s3://${src_s3_bucket}/${f}
done
