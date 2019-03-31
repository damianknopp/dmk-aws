#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh
source ../acct.sh

# tag dead letter queue
aws sqs receive-message --queue-url https://queue.amazonaws.com/${acct}/${queue_name} --max-number-of-messages 5
