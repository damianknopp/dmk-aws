#!/usr/bin/env bash

cd $( dirname "${BASH_SOURCE[0]}" )
source ../env.sh

aws kinesis list-tags-for-stream --stream-name ${stream_name} | jq .