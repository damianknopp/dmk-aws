#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh
source ../acct.sh

aws sqs send-message  --queue-url https://queue.amazonaws.com/${acct}/${queue_name} --message-body '{ bucket: "bucket1", "key": "key1" }'
