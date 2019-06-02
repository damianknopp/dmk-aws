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


# tag dead letter queue
aws --profile ${profile} sqs tag-queue --queue-url https://queue.amazonaws.com/${acct}/${queue_name}-dead --tags ${tags}
# tag queue
aws --profile ${profile} sqs tag-queue --queue-url https://queue.amazonaws.com/${acct}/${queue_name} --tags ${tags}