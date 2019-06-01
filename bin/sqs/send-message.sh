#!/usr/bin/env bash

basedir=$( dirname "${BASH_SOURCE[0]}" )
source $basedir/../env.sh
source $basedir/../acct.sh

aws --profile ${profile} sqs send-message  --queue-url https://queue.amazonaws.com/${acct}/${queue_name} --message-body '{ bucket: "bucket1", "key": "key1" }'
