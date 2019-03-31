#!/usr/bin/env bash


cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh
source ../acct.sh

echo "purging ${queue_name} this may take a minute..."
aws sqs purge-queue --queue-url https://queue.amazonaws.com/${acct}/${queue_name}