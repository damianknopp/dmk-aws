#!/usr/bin/env bash


basedir=$( dirname "${BASH_SOURCE[0]}" )
source $basedir/../env.sh
version=1.0-SNAPSHOT
sqs_client=$basedir/../../sqs-client
jar=$sqs_client/target/sqs-client-${version}.jar
queue_url="https://sqs.${region}.amazonaws.com/${acct}/${queue_name}"

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



