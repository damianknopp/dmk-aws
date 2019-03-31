#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh


echo "delete queue [${queue_name}, ${queue_name}-dead], this may take a minute..."
# delete dead letter queue
aws sqs delete-queue --queue-url "https://queue.amazonaws.com/${acct}/${queue_name}-dead"
# delete queue
aws sqs delete-queue --queue-url "https://queue.amazonaws.com/${acct}/${queue_name}"