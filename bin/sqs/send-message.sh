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

aws --profile ${profile} sqs send-message  --queue-url https://queue.amazonaws.com/${acct}/${queue_name} --message-body '{ bucket: "bucket1", "key": "key1" }'
