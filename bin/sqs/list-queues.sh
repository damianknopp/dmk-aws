#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh
source ../acct.sh

aws --profile ${profile} sqs list-queues | jq .