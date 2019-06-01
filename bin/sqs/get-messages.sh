#!/usr/bin/env bash

basedir=$( dirname "${BASH_SOURCE[0]}" )
source $basedir/../env.sh
source $basedir/../acct.sh

# tag dead letter queue
aws --profile ${profile} sqs receive-message --queue-url https://queue.amazonaws.com/${acct}/${queue_name} --max-number-of-messages 5
