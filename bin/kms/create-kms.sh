#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh

aws kms create-key --tags TagKey=environment,TagValue=demo --description "key for sqs sse demo" | jq .