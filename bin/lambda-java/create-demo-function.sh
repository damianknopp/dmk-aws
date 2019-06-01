#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh

jar_name=sqs-lambda-${version}.jar
aws --profile ${profile} lambda create-function --function-name ${demo_function} \
--runtime java8 \
--handler dmk.lambda.sqs.DemoIngestHandler \
--code "S3Bucket=${src_s3_bucket},S3Key=${jar_name}" \
--role "${lambda_role}" \
--description "a simple demo lambda" \
--timeout 900 \
--memory-size 128 \
--environment "Variables={Environment=demo}" \
--tags ${tags}

#
#[--vpc-config "SubnetIds=string,string,SecurityGroupIds=string,string" \
#[--publish | --no-publish]