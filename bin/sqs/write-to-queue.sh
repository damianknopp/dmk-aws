#!/usr/bin/env bash

# correctly get the current full base path
#   of the currently executing script
#   works on mac
OS=$(uname)
if [[ "${OS}" == "Darwin" ]]; then
    readlink_cmd=greadlink
fi
cur_script=$($readlink_cmd -f "${BASH_SOURCE[0]}")
basedir=$(dirname $cur_script)
source $basedir/../env.sh

version=1.0-SNAPSHOT
sqs_client=$basedir/../../sqs-client
jar=$sqs_client/target/sqs-client-${version}.jar
queue_url="https://sqs.${region}.amazonaws.com/${acct}/${queue_name}"

echo "$queue_url"

java -version
if [[ -f $jar ]]; then
    java -cp $jar dmk.sqs.client.SQSClientDriver \
    --region ${region} \
    --bucket ${src_s3_bucket} \
    --queue ${queue_url} \
    --profile ${profile} \
    --suffix .csv
      $*
else
    cd $sqs_client
    mvn clean install
    java -cp $jar dmk.sqs.client.SQSClientDriver \
      --region ${region} \
      --bucket ${src_s3_bucket} \
      --queue ${queue_url} \
      --profile ${profile} \
      --suffix .csv
      $*
fi



