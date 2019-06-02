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


echo "delete queue [${queue_name}, ${queue_name}-dead], this may take a minute..."
# delete dead letter queue
aws --profile ${profile} sqs delete-queue --queue-url "https://queue.amazonaws.com/${acct}/${queue_name}-dead"
# delete queue
aws --profile ${profile} sqs delete-queue --queue-url "https://queue.amazonaws.com/${acct}/${queue_name}"