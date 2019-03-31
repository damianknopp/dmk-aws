#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh
#echo $(pwd)

jar_name=sqs-lambda-${version}.jar
jar_path=../sqs-lambda/target/${jar_name}
local_checksum=$(openssl sha256 ${jar_path} | cut -d ' ' -f 2)
obj_exists=$(aws s3 ls "s3://${src_s3_bucket}/${jar_name}")
should_copy=false
if [[ ${obj_exists} != '' ]]; then
#    echo "${obj_exists}"
    remote_checksum=$(aws s3api head-object --bucket "${src_s3_bucket}" --key "${jar_name}" | jq .Metadata.checksum | tr -d '"')
#    echo "${local_checksum} ${remote_checksum}"
    if [[ "${local_checksum}" != "${remote_checksum}" ]]; then
        echo "checksum mismatch"
        should_copy="true"
    fi
else
    echo "object is not in s3"
    should_copy="true"
fi


if [[ "${should_copy}" == "true" ]]; then
    echo "copying jar"
    aws s3 cp ${jar_path} s3://${src_s3_bucket}/${jar_name} --metadata CHECKSUM-ALGO=sha256,CHECKSUM="${local_checksum}"
else
    echo "jar already exists with same checksum, skipping copy"
fi
