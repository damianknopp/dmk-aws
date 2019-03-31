#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh

# TODO: defined our demo queue arn
aws lambda create-event-source-mapping \
 --event-source-arn ${queue_arn}  \
 --function-name ${demo_function} \
 --enabled                        \
 --batch-size 1