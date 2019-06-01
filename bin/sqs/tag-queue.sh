#!/usr/bin/env bash


cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh
source ../acct.sh

# tag dead letter queue
aws --profile ${profile} sqs tag-queue --queue-url https://queue.amazonaws.com/${acct}/${queue_name}-dead --tags ${tags}
# tag queue
aws --profile ${profile} sqs tag-queue --queue-url https://queue.amazonaws.com/${acct}/${queue_name} --tags ${tags}